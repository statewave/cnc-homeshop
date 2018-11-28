#!/usr/bin/env python3

import os
import re
import sys
from optparse import OptionParser

# Format is 'include <filename>'
INCLUDE_LINE_RE = re.compile(r"include <(.*?)>;?\n?")
# Format is '(cfg:Foo-Bar: 1)'
CFG_LINE_RE = re.compile(r"\(cfg:([^:]+): ([^\)]*)\)\n?")

BASE_DIR = os.path.abspath(os.path.dirname(__file__))


class Config:
    def __init__(self):
        self.commented_linenos = set()  # 0-based
        self.lines = []
        self.lookup = {}
        self.defines = {}

    def feed(self, filename):
        """
        Add lines from the given filename, commenting out previous ones that are
        no longer in effect.
        """
        if self.lines:
            self.lines.append("\n")
        self.lines.append("(BEGIN INCLUDE OF {})\n".format(filename))
        with open(filename) as f:
            for line in f:
                if INCLUDE_LINE_RE.match(line):
                    m = INCLUDE_LINE_RE.match(line)
                    include_filename = os.path.join(
                        os.path.dirname(filename), m.group(1)
                    )
                    self.feed(include_filename)
                elif CFG_LINE_RE.match(line):
                    m = CFG_LINE_RE.match(line)
                    # TODO: Something more clear if the old and new value are
                    # identical.
                    if m.group(1) in self.lookup:
                        self.commented_linenos.add(self.lookup[m.group(1)])
                    self.lookup[m.group(1)] = len(self.lines)
                    self.lines.append(sub_match_value(m, 2, self._substitute))
                else:
                    self.lines.append(line)
        self.lines.append("(END INCLUDE of {})\n".format(filename))

    def _substitute(self, value):
        for k, v in self.defines.items():
            value = value.replace("$" + k, v)
        if "$" in value:
            # TODO: Give context about file/line
            raise AssertionError("$ remains in value: %r" % (value,))
        return value

    def write(self, filename):
        with open(filename, "w") as f:
            for i, line in enumerate(self.lines):
                if i in self.commented_linenos:
                    f.write(line.replace("cfg:", "----"))
                else:
                    f.write(line)


def sub_match_value(match, idx, func):
    replacement = func(match.group(idx))
    subject = match.group(0)
    return subject[: match.start(idx)] + replacement + subject[match.end(idx) :]


def main(args):
    """%prog [opts] <input_config>

    Generates a cammill config using includes and vars."""
    o = OptionParser(main.__doc__)
    o.add_option("-o", "--output", dest="output", help="Output filename")
    o.add_option(
        "-D",
        "--define",
        dest="define",
        action="append",
        help="Define a constant as <key>=<value>",
    )
    # TODO: Include path -I
    opts, args = o.parse_args(args)

    c = Config()
    if opts.define:
        c.defines = dict(v.split("=", 1) for v in opts.define)
    for filename in args:
        c.feed(filename)

    c.write(opts.output)


if __name__ == "__main__":
    main(sys.argv[1:])
