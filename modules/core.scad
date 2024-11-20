include <../config.scad>;
include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;
pad_groove_outer_radius=9.6;
pad_groove_inner_radius=7.1;
pad_groove_depth=1;
bearing_groove_outer_radius=pad_groove_inner_radius-0.4;
bearing_groove_mid_radius=bearing_mount_radius;
bearing_groove_inner_radius=3.175;

module core_outline_profile() {
    module center_bump() {
        translate([0, -bearing_mount_protrude_length, 0]) square([bearing_groove_inner_radius, bearing_mount_protrude_length]);
    }
    module base() {
        square( [core_radius, core_min_thickness]);
    }
    module support() {
        difference() {
            translate([bearing_groove_mid_radius-eps, core_min_thickness-eps, 0]) square(core_radius-bearing_groove_mid_radius+eps);
            translate([core_radius, core_radius-bearing_groove_mid_radius+core_min_thickness])
            circle(core_radius-bearing_groove_mid_radius);
        }
    }
    module axle() {
        square([bearing_groove_mid_radius, face_center_width]);
    }
    union(){
        center_bump();
        base();
        axle();
        support();
    }
}
module core_outline() {
    rotate([180, 0, 0]) rotate_extrude() core_outline_profile();
}

module core_groove_profile() {
    module pad() {
        translate([pad_groove_inner_radius, -eps, 0]) square([pad_groove_outer_radius-pad_groove_inner_radius, pad_groove_depth+eps]);
    }
    module bearing_outer() {
        translate([bearing_groove_mid_radius, -eps, 0]) square([bearing_groove_outer_radius-bearing_groove_mid_radius, pad_groove_depth+eps]);
    }
    module bearing_inner() {
        translate([bearing_groove_inner_radius, -eps, 0]) square([
        bearing_groove_mid_radius-bearing_groove_inner_radius+eps, bearing_mount_depth+eps]);;
    }
    union() {
        pad();
        bearing_outer();
        bearing_inner();
    }
}
module core_groove(){
    rotate([180, 0, 0]) rotate_extrude() core_groove_profile();
}
   
module core_hole(){
    rotate([180, 0, 0]) {
        union(){
            translate([0, 0, bolt_hole_body_length-bearing_mount_protrude_length]) nut_trap_inline(width/2-bolt_hole_body_length, "M4");
            translate([0, 0, bolt_hole_body_length/2-bearing_mount_protrude_length]) screw_hole("M4", head="none", length=bolt_hole_body_length+eps);
        }
    }
}

module core() {
    difference(){
        core_outline();
        core_groove();
        core_hole();
    }
}
core();
//core_groove();