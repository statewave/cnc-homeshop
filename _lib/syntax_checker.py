import re
import os
import sys
import enum

open_braces = "([{"
close_braces = ")]}"

CHECKED_FILES = {}

# Patterns to improve:
# - includes can have spaces?
# - number (allows 0.0.0)
# - string (does not do any escpaes or multiline?)
# - are keywords case-sensitive?
# - module prefixes: ! # % *
# - module names: for, let, assert, echo, each
# - ranages [a:b] [a:b:c] [1, 2, 3] literal
# - double check NE
# - prefix +-!
# - ternary

# TODO: There's an oddity around \ua0 being allowed as whitespace, but no
# unicode-raw string so including it will be ugly.
TOKENIZER_RE = re.compile(
    r"""
    (?P<whitespace>\s+) |
    (?P<comment>//.*) |
    (?P<mlcomment>/\*[\w\W]*?\*/) |
    (?P<number>[+\-]?(\d+\.\d*([eE][+-]?\d+)? |
                      \d*\.\d+([eE][+-]?\d+)? |
                      \d+([eE][+-]?\d+)? )) |
    (?P<boolean>true|false|undef)\b |
    (?P<let>let)\b |
    (?P<simple_string>"[^"]*") |
    (?P<include>\binclude\s*<\s*(?P<include_name>[^\s>]+)\s*>) |
    (?P<reserved>module|function|if|else|for|let|assert|echo|each)\b |
    (?P<hash>\#) |
    (?P<ternary>\?) |
    (?P<colon>:) |
    (?P<comma>,) |
    (?P<semicolon>;) |
    (?P<paren>[()]) |
    (?P<square>[\[\]]) |
    (?P<curly>[{}]) |
    (?P<operator>!|\+|-|\*|/|%|\<|\>|\<=|\>=|==|\!=|&&|\|\|) |
    (?P<assign>=) |
    (?P<name>(?![0-9])[a-zA-Z0-9$_]+)  # leading numbers are matched above
""",
    re.X | re.U,
)
GROUP_MAP = {v: k for k, v in TOKENIZER_RE.groupindex.items()}


def gettype(m):
    i = 1
    # This takes lowest group in case they're nested...
    while True:
        if m.group(i):
            return GROUP_MAP[i]
        i += 1


def check(base_dir, filename):
    absfilename = os.path.join(base_dir, filename)
    absdir = os.path.dirname(absfilename)
    if absfilename in CHECKED_FILES:
        # TODO still check for shadowed names
        return
    f = CHECKED_FILES[absfilename] = ScadFile(absfilename)
    print("Checking", base_dir, filename, absfilename)
    if not f.parse() or not f.verify():
        print(f.fatal_errors)
        sys.exit(1)
    for inc in f.includes:
        check(absdir, inc)


class NameType(enum.Enum):
    SCALAR = 1
    FUNCTION = 2
    MODULE = 3


class ScadFile(object):
    """
    A terrible parser for OpenSCAD files.

    Yes, it's quite terrible.
    """

    def __init__(self, abs_filename, data=None):
        self.includes = []
        self.lint_warnings = []
        self.fatal_errors = []
        self.abs_filename = abs_filename
        # Primarily for testing.
        self.data = data
        self.dirname = os.path.dirname(abs_filename)
        # TODO include children names?
        # name -> NameType
        self.global_names = {}
        self.tokens = []

    def parse(self):
        if self.data is not None:
            data = self.data
        else:
            with open(self.abs_filename) as fo:
                data = fo.read()
        idx = 0
        lnum = 1
        cnum = 1
        for match in TOKENIZER_RE.finditer(data):
            if match.start() != idx:
                self.fatal_errors.append(
                    (
                        lnum,
                        cnum,
                        "Skipped some bytes: %r" % (data[idx : match.start()],),
                    )
                )
                return False

            ttype = gettype(match)
            text = match.group(0)
            self.tokens.append(
                (
                    ttype,
                    lnum,
                    cnum,
                    text,
                    {k: v for k, v in match.groupdict().items() if v is not None},
                )
            )

            # TODO unicode cnum
            lnum += text.count("\n")
            if "\n" in text:
                cnum = len(text.split("\n")[-1]) + 1
            else:
                cnum += len(text)

            idx = match.end()

        if idx != len(data):
            self.fatal_errors.append(
                (lnum, cnum, "Skipped some bytes at EOF: %r" % (data[idx:],))
            )
            return False

        return True

    def verify(self):
        stack = []
        i = 0

        while i < len(self.tokens):
            ttype, lnum, cnum, text, groups = self.tokens[i]
            print(i, ttype, repr(text))
            if ttype == "include":
                self.includes.append(groups["include_name"])
            elif ttype == "reserved" and text == "function":
                i += 1
                while self.tokens[i][0] in ("whitespace", "comment", "mlcomment"):
                    i += 1
                assert self.tokens[i][0] == "name"
                self.global_names[self.tokens[i][3]] = NameType.FUNCTION
            elif ttype == "reserved" and text == "module":
                i += 1
                while self.tokens[i][0] in ("whitespace", "comment", "mlcomment"):
                    i += 1
                assert self.tokens[i][0] == "name"
                self.global_names[self.tokens[i][3]] = NameType.MODULE
            elif ttype in ("paren", "curly", "square"):
                # TODO additional context about function/module name
                if text in open_braces:
                    stack.append((text, lnum))
                else:
                    x = close_braces.index(text)
                    if not stack:
                        self.fatal_errors.append(
                            (lnum, cnum, "Found %s but nothing open" % (text,))
                        )
                        return False
                    elif open_braces.index(stack[-1][0]) != x:
                        self.fatal_errors.append(
                            (
                                lnum,
                                cnum,
                                "Wrong brace: %s vs %s from line %d"
                                % (text, stack[-1][0], stack[-1][1]),
                            )
                        )
                        return False
                    else:
                        stack.pop()
            i += 1

        if stack:
            self.fatal_errors.append((lnum, cnum, "Open braces at EOF: %s" % (stack,)))
            return False
        return True


if __name__ == "__main__":
    base_dir = os.getcwd()
    for filename in sys.argv[1:]:
        dirname, filename = os.path.split(filename)
        os.chdir(base_dir)
        if dirname:
            os.chdir(dirname)
        check(base_dir, filename)
