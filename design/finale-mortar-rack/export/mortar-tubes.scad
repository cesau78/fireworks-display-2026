// Export all 25 mortar tubes (one rack).
$fn = 48;
FINALE_RACK_ASSEMBLY = true;
show_tubes = true;
show_row_dowels_top = false;
include <../config.scad>
include <../layout.scad>
include <../rack-modules.scad>

rack_assembly();
