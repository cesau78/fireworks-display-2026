// Export both outer (2 in.) top dowels.
$fn = 48;
FINALE_RACK_ASSEMBLY = true;
include <../config.scad>
include <../layout.scad>
include <../row-dowel-top-middle.scad>
include <../rack-modules.scad>

for (i = row_dowel_middle_i)
  row_dowel_top_at(i) row_dowel_top_middle_cylinder();
