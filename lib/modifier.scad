include <specs.scad>;
include <config.example.scad>;
use <core.scad>;

module infill_modifier_profile(body_size,  bolt_nut_length, weight_layer_thickness){
    weight_outer_radius=sqrt(body_size[0]^2 + body_size[1]^2);
    weight_inner_radius=weight_outer_radius-weight_layer_thickness;
    module rim_profile() {
        module base() {
            translate([0, -bearing_width/2, 0]) square([body_size[0], body_size[1]+bearing_width/2]);
        }
        module hollow() {
            difference(){
                circle(weight_outer_radius);
                circle(weight_inner_radius);
            }
        }
        intersection() {
            base();
            hollow();
        }
            
    }
    rim_profile();
    core_outline_profile(bolt_nut_length);
}

module infill_modifier(body_size,  bolt_nut_length, weight_layer_thickness) {
    rotate([180, 0, 0]) rotate_extrude() {
        infill_modifier_profile(body_size,  bolt_nut_length, weight_layer_thickness);
    }
}

difference() {
    infill_modifier(body_size, bolt_nut_length, weight_layer_thickness);
    translate([0, 0, - body_size[1]-eps]) cube([body_size[0], body_size[0], body_size[1]+bearing_width/2+2*eps]);
}
