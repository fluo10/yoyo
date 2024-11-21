include <config.scad>;
include <modules/specs.scad>;
use <modules/core.scad>;

function face_curve_bottom_radius(body_radius, rim_thickness)=(body_radius - rim_thickness + bearing_mount_radius*2)/3;
function face_curve_bottom_width(bolt_body_length,nut_thickness)=face_center_width(bolt_body_length, nut_thickness)-1;

module round_body_profile(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness) {

    module base() {
        union() {
            intersection() {
                translate([core_radius-eps, body_width-edge_radius, 0]) resize([ (body_radius-core_radius)*2 +eps,(body_width-edge_radius)*2, 0]) circle(100);
                translate([core_radius-eps, 0, 0]) square([body_radius-core_radius+eps, body_width-edge_radius]);
            }
            translate([bearing_mount_radius+center_edge_radius_max, 0, 0]) square([core_radius-bearing_mount_radius-center_edge_radius_max, body_width-edge_radius]);
            square([bearing_mount_radius + center_edge_radius_max, face_center_width(bolt_body_length, nut_thickness)-center_edge_radius_min]);
            
            translate([bearing_mount_radius, face_center_width(bolt_body_length, nut_thickness)-center_edge_radius_min]) resize([center_edge_radius_max+eps, center_edge_radius_min+eps,1]) intersection() {
                circle(1);
                square(1);
            }
                
        }
        
    }
    module rim() {
        hull(){
            translate([body_radius-edge_radius, body_width-edge_radius,0]) circle(edge_radius);
            translate([body_radius-rim_thickness+edge_radius, body_width-edge_radius, 0]) circle(edge_radius);
        }
    }
    module face_inner_curve() {
        translate([face_curve_bottom_radius(body_radius, rim_thickness), face_center_width(bolt_body_length, nut_thickness)-center_edge_radius_min]) resize([face_curve_bottom_radius(body_radius, rim_thickness)-bearing_mount_radius-center_edge_radius_max, face_center_width(bolt_body_length, nut_thickness)-face_curve_bottom_width(bolt_body_length, nut_thickness)-center_edge_radius_min]) rotate([0,0,  180])  intersection() {
            circle(1);
            square(1);
        }
        translate([face_curve_bottom_radius(body_radius, rim_thickness), face_center_width(bolt_body_length, nut_thickness)-center_edge_radius_min,0]) rotate([0, 180, 0])square([face_curve_bottom_radius(body_radius, rim_thickness)-bearing_mount_radius-center_edge_radius_max, body_width]);
        
    }
    module face_outer_curve() {
        translate([face_curve_bottom_radius(body_radius, rim_thickness), body_width-edge_radius, 0])resize([body_radius - rim_thickness-face_curve_bottom_radius(body_radius, rim_thickness), body_width-face_curve_bottom_width(bolt_body_length, nut_thickness)-edge_radius, 1])  rotate([180, 0, 0]) intersection(){
            circle(1);
            square(1);
        }
    }

    difference() {
        union(){
            base();
            rim();
            core_outline_profile(bolt_body_length, nut_thickness);
        }
        face_inner_curve();
        face_outer_curve();
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
    }
}

if($preview) {
    difference() {
        round_yoyo(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness);
        //translate([0, 0, - body_width]) cube([body_radius, body_radius, body_width+bearing_width/2]);
    };
} else {
    round_yoyo(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness);
}

//translate([10, 0, 0]) round_body();