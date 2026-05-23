// Export both outside row boards (front & back).
$fn = 48;
FINALE_RACK_ASSEMBLY = true;
include <../config.scad>
include <../layout.scad>
include <../row-board-bottom.scad>

row_boards_bottom();
