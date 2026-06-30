// Single brown end wall blank (24 x 3-1/2 x 5/8 in.).
$fn = 48;
preview = false;
include <../config.scad>
include <../layout.scad>
use <../row-board-bottom.scad>

row_board_bottom(end_wall_inner_front_y() - wall_thickness_in);
