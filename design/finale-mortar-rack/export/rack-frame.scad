// Export rack frame only (no tubes) — lighter STL for web preview.
$fn = 48;
FINALE_RACK_ASSEMBLY = true;
show_tubes = false;
show_row_dowels_top = true;
include <../config.scad>
include <../layout.scad>
include <../row-board-bottom.scad>
include <../column-board-bottom.scad>
include <../row-board-middle.scad>
include <../row-dowel-top-inner.scad>
include <../row-dowel-top-middle.scad>
include <../rack-modules.scad>

row_boards_bottom();
column_boards_bottom();
row_boards_middle();
row_dowels_top();
