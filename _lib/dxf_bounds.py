# This will list the bounding box for a given (set of) dxf files.
# * Supports two modes -- lower-left zero, and preserve zero.
# * Only includes independent line segments at the moment (as produced from
#   openscad).

import sys
import optparse
import ezdxf

class Bounds(object):
  def __init__(self):
    self.min_x = 1e300
    self.max_x = -1e300
    self.min_y = 1e300
    self.max_y = -1e300

  def upd(self, pt):
    self.min_x = min(self.min_x, pt[0])
    self.max_x = max(self.max_x, pt[0])
    self.min_y = min(self.min_y, pt[1])
    self.max_y = max(self.max_y, pt[1])

  def autozero(self):
    self.max_x -= self.min_x; self.min_x = 0
    self.may_y -= self.min_y; self.min_y = 0


def main(args):
  p = optparse.OptionParser()
  p.add_option("-z")
  opts, args = p.parse_args(args)

  bounds = Bounds()

  for f in args:
    print("Parsing %s" % (f,))
    doc = ezdxf.readfile(f)
    for line in doc.modelspace().query("LINE"):
      bounds.upd(line.dxf.start)
      bounds.upd(line.dxf.end)
  

  # TODO: Verify numbers match
  if opts.z == 0:
    # auto, from cammill constant
    bounds.autozero()

  # TODO: Sig figs
  print("min=[%s,%s]" % (bounds.min_x, bounds.min_y))
  print("max=[%s,%s]" % (bounds.max_x, bounds.max_y))
  
  
if __name__ == '__main__':
  main(sys.argv[1:])
