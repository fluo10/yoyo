include <config.scad>;
include <modules/specs.scad>;
use <modules/core.scad>;

module yoyo_weight_modifier(body_radius, body_width,  bolt_body_length, nut_thickness, weight_layer_thickness) {
    weight_outer_radius=sqrt(body_radius^2 + body_width^2);
    weight_inner_radius=weight_outer_radius-weight_layer_thickness;
    module rim_profile() {
        module base() {
            translate([0, -bearing_width/2, 0]) square([body_radius, body_width+bearing_width/2]);
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
    
    rotate([180, 0, 0]) rotate_extrude() {
   
        rim_profile();
        core_outline_profile(bolt_body_length, nut_thickness);
    }
}

if($preview) {
    difference() {
        yoyo_weight_modifier(body_radius, body_width, bolt_body_length, nut_thickness, weight_layer_thickness);
        translate([0, 0, - body_width]) cube([body_radius, body_radius, body_width+bearing_width/2]);
    }
} else {
    yoyo_weight_modifier(body_radius, body_width, bolt_body_length, nut_thickness, weight_layer_thickness);
}