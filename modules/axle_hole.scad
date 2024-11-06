include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

axle_length=12;
bearing_width=4;
hole_depth_margin=0.2;

module axle_hole () {
    rotate([0, 90, 0]) screw_hole("M4", "none", thread=true, length=axle_length-bearing_width+hole_depth_margin);
}

difference() {
    translate([3.5, 0, 0]) rotate([0, 90, 0]) cylinder(h=7, r=3, center=true);
    axle_hole();
}