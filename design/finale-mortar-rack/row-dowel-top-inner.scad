// Inner top dowel (±2 in. X): cylinder along +Y, origin at geometric center.
// rack.scad places row_dowel_inner_i instances.
include <config.scad>
include <layout.scad>

module row_dowel_top_inner_cylinder() {
  color(color_dowel_standard)
    rotate([90, 0, 0])
      cylinder(h = row_dowel_length_y_in(), d = row_dowel_od_inner_in, center = true);
}

if (is_undef(FINALE_RACK_ASSEMBLY))
  row_dowel_top_inner_cylinder();
