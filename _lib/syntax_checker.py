import os
import sys

open_braces = '([{'
close_braces = ')]}'

CHECKED = set()

def check(filename):
    absfilename = os.path.abspath(filename)
    if absfilename in CHECKED:
        return
    CHECKED.add(absfilename)
    print("Checking " + filename)
    with open(filename) as fo:
        lnum = 0
        stack = []
        for line in fo:
            lnum += 1
            # TODO this shouldn't be line-based, but statement-based.  includes
            # can span lines?
            # TODO parse strings
            if line.startswith('include'):
                check(line.split('<')[1].split('>')[0])
            else:
                for c in line:
                    if c in open_braces:
                        stack.append((c, lnum))
                    elif c in close_braces:
                        i = close_braces.index(c)
                        if not stack:
                            print("Found %s on line %d but nothing open" %
                                  (c, lnum))
                            sys.exit(1)
                        elif open_braces.index(stack[-1][0]) != i:
                            print("Wrong brace on line %d: %s vs %s from line %d" %
                                  (lnum, c, stack[-1][0], stack[-1][1]))
                            sys.exit(1)
                        else:
                            stack.pop()
        if stack:
            print("Open braces at EOF: %s" % (stack,))
            sys.exit(1)


if __name__ == '__main__':
    base_dir = os.getcwd()
    for filename in sys.argv[1:]:
        dirname, filename = os.path.split(filename)
        os.chdir(base_dir)
        if dirname:
            os.chdir(dirname)
        check(filename)

