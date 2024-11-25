include <config.scad>;
include <modules/specs.scad>;
use <modules/core.scad>;
use <modules/face.scad>;

function face_curve_bottom_radius(body_radius, rim_thickness)=(body_radius - rim_thickness + bearing_mount_radius*2)/3;
function face_curve_bottom_width(bolt_body_length,nut_thickness)=face_center_width(bolt_body_length, nut_thickness)-1;

module round_body_profile(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness) {

    module base() {
        union() {
            minkowski(){
                translate([core_radius-eps, body_width-edge_radius, 0]) resize([body_radius-core_radius-edge_radius+eps, body_width-edge_radius*2]) rotate([180, 0, 0]) intersection(){
                    square(1);
                    circle(1);
                }
                circle(edge_radius);
            }
            translate([bearing_mount_radius, 0, 0]) square([core_radius-bearing_mount_radius, body_width]);
            square([bearing_mount_radius + center_edge_radius_max, face_center_width(bolt_body_length, nut_thickness)-center_edge_radius_min]);
            
          
                
        }
        
    }


    difference() {
        union(){
            base();
            //rim();
            core_outline_profile(bolt_body_length, nut_thickness);
        }
    }
}
module round_body(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness) {
    rotate([180, 0, 0]) rotate_extrude() round_body_profile(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness);
}
module round_yoyo(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness) {
    difference() {
        round_body(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness);
        core_groove();
        core_hole(bolt_body_length, nut_thickness);
        face_hole(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, face_groove_size);
    }
}

if($preview) {
    difference() {
        round_yoyo(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness);
        translate([0, 0, - body_width]) cube([body_radius, body_radius, body_width+bearing_width/2]);
    };
} else {
    round_yoyo(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness);
}

//translate([10, 0, 0]) round_body();