include <../../_lib/edge_tabs.scad>;
include <../../_lib/fillets.scad>;
include <../../_lib/supported_rail.scad>;

// table 34x36 (shorter in plunge direction)
// back 33cm apart (inside)
// 15cm from top of table to bottom of template
gBitSize = 4;
gMaterialThick = 18.0;
gCutDepth = -gMaterialThick-0.2;
gPocketDepth = 5;

// Reduction is the ratio of these two; typically 2:1
gLinkage = [120, 240];
gWebsInset = [40, 60];

gLinkageWidth = 30;
gRouterDia = 89;
gPivotSize = 8;
gFollowerSize = 6;

gLinkThick = 18;
// I-beam vertical
gWebbingThick = 12;

// For RouterLink, leave this much around the edge.  Set to 0 for solid.
gBulk = 25;

gRail1Pos = [-100,20];
gRail2Pos = [100,20];
gRail1Blocks = [25];
gRail2Blocks = [25,225];

gTableHigh = 180;

gPivotTabs = [
  [LEFT_EDGE, -36],
  [CTAB, -20, 20],
  [CTAB, 20, 20],
  [RIGHT_EDGE, 36],
];

gBaseShortEdgeTabs = [
  [LEFT_EDGE, 0],
  [CTAB, 70, 30],
  [CTAB, 150, 30],
  [CTAB, 300-70, 30],
  [RIGHT_EDGE, 300],
];

gBaseLongEdgeTabs = [
  [LEFT_EDGE, 0],
  [CTAB, 30, 20],
  [CTAB, 70, 20],
  [CTAB, 110, 20],
  [CTAB, 150, 20],
  [CTAB, 195, 30],
  [RIGHT_EDGE, 230],
];

gClampyFrontTabs = [
  [LEFT_EDGE, 0], // TODO: problem here
  [CTAB, 30, 20],
  [CTAB, 70, 20],
  [RIGHT_EDGE, 100],
];

gTowerTabs = [
  [LEFT_EDGE, 0],
  [CTAB, 30, 20],
  [CTAB, 70, 30],
  [RIGHT_EDGE, 120],
];

include <lib_links.scad>;
include <lib_base.scad>;
include <lib_table.scad>;
include <lib_clampy.scad>;
