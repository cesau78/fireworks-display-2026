// Single blue mid-height row divider blank.
$fn = 48;
preview = false;
include <../config.scad>
include <../layout.scad>
use <../row-board-middle.scad>

row_board_middle(middle_row_divider_center_y(1));
