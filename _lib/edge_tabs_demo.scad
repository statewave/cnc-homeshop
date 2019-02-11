include <edge_tabs.scad>;

thick = 12;
demo_size = [200, 60];
tabs = [
  [LEFT_EDGE, 0],
  [TAB, 40, 20],
  [TAB, 90, 20],
  [TAB, 140, 20],
  [RIGHT_EDGE, demo_size[0]],
];
vtabs = [
  [LEFT_EDGE, 0],
  [CTAB, 30, 20],
  [RIGHT_EDGE, 60],
];


difference() {
  square(demo_size);

  translate([0,demo_size[1]/2-thick/2])
    MiddleSlots(4, thick, tabs);

  EdgeTabF(4, thick, tabs);
  TabsToTop(demo_size) EdgeTabM(4, thick, tabs);

  TabsToLeft(demo_size) EdgeTabF(3, thick, vtabs);
  TabsToRight(demo_size) EdgeTabM(3, thick, vtabs);
}

translate([0,-demo_size[1]-2]) difference() {
  square(demo_size);
  TabsToTop(demo_size) EdgeTabM(4, thick, tabs);
}

