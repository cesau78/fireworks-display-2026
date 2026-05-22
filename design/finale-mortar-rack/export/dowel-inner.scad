// Single inner dowel (1.5 in. OD x 18 in.).
$fn = 48;
preview = false;
include <../config.scad>
include <../layout.scad>
use <../row-dowel-top-inner.scad>

row_dowel_top_inner_cylinder();
