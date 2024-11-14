include <global_variables.scad>;
body_radius=28;
body_width=22;
rim_thickness=10;
rim_depth=4;

module body_profile() {
    module base() {
        intersection() {
            translate([core_radius, body_width, 0]) resize([ (body_radius-core_radius)*2 ,body_width*2, 0]) circle(100);
            translate([core_radius, 0, 0]) square([body_radius-core_radius, body_width]);
        }
    }
    module inner_curve() {
        translate([core_radius, body_width-rim_depth]) resize([(body_radius-rim_thickness-core_radius)*2, (body_width-core_thickness-rim_depth)*2, 0]) circle(100);
        translate([body_radius-rim_thickness*2,body_width-rim_depth,0]) square([rim_thickness, rim_depth]); 
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
module body() {
    rotate_extrude() body_profile();
}
//translate([0, 0, 0]) body_profile();
translate([10, 0, 0]) body();