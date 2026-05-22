// Middle top dowel (±6 in. X): cylinder along +Y, origin at geometric center.
// rack.scad places row_dowel_middle_i instances.
include <config.scad>
include <layout.scad>

module row_dowel_top_middle_cylinder() {
  color(color_dowel_middle)
    rotate([90, 0, 0])
      cylinder(h = row_dowel_length_y_in(), d = row_dowel_od_middle_in, center = true);
}

if (is_undef(FINALE_RACK_ASSEMBLY))
  row_dowel_top_middle_cylinder();
