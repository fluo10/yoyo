include <global_variables.scad>;
include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;
use <core_base.scad>;

bolt_body_length=20;

module bolted_core(bolt_body_length=bolt_body_length) {
    bolt_nut_interval_length=bolt_body_length-3;
    bolt_hole_length=max(core_thickness-bearing_center_offset, bolt_nut_interval_length/2+3);
    bolt_hole_bump_length=max(0, -core_thickness+bearing_center_offset+ bolt_hole_length);
    bolt_hole_body_length=bolt_nut_interval_length/2;
    bolt_hole_head_length=bolt_hole_length - bolt_hole_body_length;
        
    module bolted_core_hole(){
        rotate([0, 90, 0]) {
            union(){
                translate([0, 0, core_thickness + bolt_hole_bump_length]) rotate([180, 0, 0]) nut_trap_inline(bolt_hole_head_length, "M4");
                translate([0, 0, bearing_center_offset+bolt_hole_body_length/2]) screw_hole("M4", head="none", length=bolt_hole_body_length);
            }
        }
    }
    module bolted_core_bump() {
        rotate([0, 90, 0]) rotate_extrude(){
            difference(){
                translate([core_radius/2, core_thickness+bolt_hole_bump_length/2, 0]) square([core_radius, bolt_hole_bump_length], center=true);
                translate([core_radius, core_thickness+bolt_hole_bump_length, 0]) resize([(core_radius - 5)*2, bolt_hole_bump_length*2, 0]) circle(10);
                
            }
        }
    }
    difference() {
        union(){
            core_base();
            bolted_core_bump();
        }
        bolted_core_hole();
    }
}

difference() {
    bolted_core();
    translate([-2, 0, 0]) cube([15, 10, 10]);
}