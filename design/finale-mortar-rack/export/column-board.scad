// Single green column divider blank (18 x 3-1/2 x 1/2 in.).
$fn = 48;
preview = false;
include <../config.scad>
include <../layout.scad>
use <../column-board-bottom.scad>

column_board_bottom(x_divider_center_x(2));
