// Export both inner (1.5 in.) top dowels.
$fn = 48;
FINALE_RACK_ASSEMBLY = true;
include <../config.scad>
include <../layout.scad>
include <../row-dowel-top-inner.scad>
include <../rack-modules.scad>

for (i = row_dowel_inner_i)
  row_dowel_top_at(i) row_dowel_top_inner_cylinder();
