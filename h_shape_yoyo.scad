include <config.scad>;
include <modules/specs.scad>;
use <modules/core.scad>;
use <modules/face.scad>;


module h_shape_body_profile(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, mid_size_ratio, face_groove_size) {
    module outer_shape(size) {
        angle=60;
        resize(size) intersection() {
            square([1-sin(angle), cos(angle)]);
            translate([-sin(angle),cos(angle), 0]) circle(1);
        }
    }
    module mid_shape(size) {
        module mid_shape_unit() {
            angles=[30, 60];
            
            difference(){
                square([cos(angles[0])-cos(angles[1]),sin(angles[1])-sin(angles[0])]);
                translate([cos(angles[0]),-sin(angles[0]), 0]) circle(1);
            }
        }
        resize(size) mid_shape_unit();
    }
    minkowski(){
        union(){
            
            translate([ mid_size_ratio[0]*body_radius, mid_size_ratio[1]*body_width, 0]) outer_shape([body_radius*(1-mid_size_ratio[0])-edge_radius,body_width*(1-mid_size_ratio[1])-edge_radius]);
            translate([ core_radius,edge_radius, 0]) mid_shape([body_radius*mid_size_ratio[0]-core_radius+eps, body_width*mid_size_ratio[1]-edge_radius+eps]);
            translate([core_radius, mid_size_ratio[1]*body_width]) square([mid_size_ratio[0]*body_radius-core_radius, (1-mid_size_ratio[1])*body_width-edge_radius]);
        }
        circle(edge_radius);
    }
    translate([bearing_mount_radius, 0, 0]) square([core_radius-bearing_mount_radius+eps, body_width]);
}
module h_shape_body(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, mid_size_ratio, face_groove_size){
    rotate([180, 0, 0]) rotate_extrude()union(){    h_shape_body_profile(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, mid_size_ratio);
        core_outline_profile(bolt_body_length, nut_thickness);
    }
}
module h_shape_yoyo(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, mid_size_ratio, face_groove_size){
    difference(){
        h_shape_body(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, mid_size_ratio, face_groove_size);
        core_groove();
        core_hole(bolt_body_length, nut_thickness);
        if($preview) {
            translate([0, 0, - body_width-eps]) cube([body_radius, body_radius, body_width+bearing_width/2+2*eps]);
        }
        face_hole(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, face_groove_size);
    }
}


h_shape_yoyo(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, h_body_mid_size_ratio);

