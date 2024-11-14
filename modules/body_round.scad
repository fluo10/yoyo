include <global_variables.scad>;


module round_body_profile() {
    module base() {
        intersection() {
            translate([core_radius, body_width, 0]) resize([ (body_radius-core_radius)*2 ,body_width*2, 0]) circle(100);
            translate([core_radius, 0, 0]) square([body_radius-core_radius, body_width]);
        }
    }
    module inner_curve() {
        translate([core_radius, body_width, 0]) resize([(body_radius-rim_thickness-core_radius)*2, (body_width-core_thickness)*2, 0]) circle(100);
    }
    module core() {
        square( [core_radius, core_thickness]);
    }
    difference() {
        base();
        inner_curve();
        core();
    }
}
module round_body() {
    rotate([0, 90, 0]) rotate_extrude() round_body_profile();
}
translate([0, 0, 0]) round_body_profile();
//translate([10, 0, 0]) round_body();