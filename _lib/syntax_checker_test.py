import unittest

import syntax_checker as sc

class SyntaxCheckerTest(unittest.TestCase):
    def test_empty(self):
        o = sc.ScadFile('/foo.scad', data='')
        self.assertEqual(True, o.parse(), o.fatal_errors)
        self.assertEqual(True, o.verify())

    def test_short(self):
        o = sc.ScadFile('/foo.scad', data='a = 1;\n  b = 2;')
        self.assertEqual(True, o.parse(), o.fatal_errors)
        self.assertEqual(True, o.verify())

    def test_nesting(self):
        o = sc.ScadFile('/foo.scad', data='(')
        self.assertEqual(True, o.parse(), o.fatal_errors)
        self.assertEqual(False, o.verify())

        o = sc.ScadFile('/foo.scad', data=')')
        self.assertEqual(True, o.parse(), o.fatal_errors)
        self.assertEqual(False, o.verify())

    def test_strings(self):
        o = sc.ScadFile('/foo.scad', data='x="([{"')
        self.assertEqual(True, o.parse(), o.fatal_errors)
        self.assertEqual(True, o.verify())

    def test_includes(self):
        o = sc.ScadFile('/a/foo.scad', data='include < ../b/bar.scad > ;')
        self.assertEqual(True, o.parse(), o.fatal_errors)
        self.assertEqual(True, o.verify())
        self.assertEqual(['../b/bar.scad'], o.includes)

    def test_number_parsing(self):
        o = sc.ScadFile('/a/foo.scad', data='[1, 1.1, .1, 1.]')
        o.parse()
        for line in o.tokens:
            print(line)
        self.assertEqual(True, o.parse(), o.fatal_errors)
        self.assertEqual(True, o.verify())

    def test_globals(self):
        o = sc.ScadFile('/a/foo.scad', data='function f(a,b=1) = [n]; module foo() { }')
        o.parse()
        o.verify()
        self.assertEqual(sc.NameType.FUNCTION, o.global_names['f'])
        self.assertEqual(sc.NameType.MODULE, o.global_names['foo'])
