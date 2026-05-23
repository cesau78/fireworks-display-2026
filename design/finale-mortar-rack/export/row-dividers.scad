// Export all four row dividers (between tube rows).
$fn = 48;
FINALE_RACK_ASSEMBLY = true;
include <../config.scad>
include <../layout.scad>
include <../row-board-middle.scad>

row_boards_middle();
