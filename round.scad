include <config.scad>;
use <modules/core.scad>;


module round_body_profile() {

    module base() {
        union() {
            intersection() {
                translate([core_radius, body_width-edge_radius, 0]) resize([ (body_radius-core_radius)*2 ,(body_width-edge_radius)*2, 0]) circle(100);
                translate([core_radius, 0, 0]) square([body_radius-core_radius, body_width-edge_radius]);
            }
            square([core_radius, face_center_width-center_edge_radius_min]);
            translate([bearing_mount_radius, face_center_width-center_edge_radius_min]) resize([center_edge_radius_max, center_edge_radius_min,1]) intersection() {
                circle(1);
                square(1);
            }
                
        }
        
    }
    module rim() {
        hull(){
            translate([body_radius-edge_radius, body_width-edge_radius,0]) circle(edge_radius);
            translate([body_radius-round_body_rim_thickness+edge_radius, body_width-edge_radius, 0]) circle(edge_radius);
        }
    }
    module face_inner_curve() {
        translate([face_curve_bottom_radius, face_center_width-center_edge_radius_min]) resize([face_curve_bottom_radius-bearing_mount_radius-center_edge_radius_max, face_center_width-face_curve_bottom_width-center_edge_radius_min]) rotate([0,0,  180])  intersection() {
            circle(1);
            square(1);
        }
        
    }
    module face_outer_curve() {
        translate([face_curve_bottom_radius, body_width-edge_radius, 0])resize([body_radius - round_body_rim_thickness-face_curve_bottom_radius, body_width-face_curve_bottom_width-edge_radius, 1])  rotate([180, 0, 0]) intersection(){
            circle(1);
            square(1);
        }
    }

    difference() {
        union(){
            base();
            rim();
            core_outline_profile();
        }
        face_inner_curve();
        face_outer_curve();
    }
}
module round_body() {
    rotate([180, 0, 0]) rotate_extrude() round_body_profile();
}
module round_yoyo() {
    difference() {
        round_body();
        core_groove();
        core_hole();
    }
}

if($preview) {
    difference() {
        round_yoyo();
        translate([0, 0, - body_width]) cube([body_radius, body_radius, body_width+bearing_mount_protrude_length]);
    }
} else {
    translate([0, 0, 0]) union() {
        round_yoyo();
    }
}
//translate([10, 0, 0]) round_body();