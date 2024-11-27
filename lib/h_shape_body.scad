include <config.example.scad>;
include <specs.scad>;
use <core.scad>;
use <face.scad>;


module h_shape_body_profile(body_size, rim_thickness, bolt_nut_length, mid_size_ratio, face_groove_size) {
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
            
            translate([ mid_size_ratio[0]*body_size[0], mid_size_ratio[1]*body_size[1], 0]) outer_shape([body_size[0]*(1-mid_size_ratio[0])-edge_radius,body_size[1]*(1-mid_size_ratio[1])-edge_radius]);
            translate([ core_radius,edge_radius, 0]) mid_shape([body_size[0]*mid_size_ratio[0]-core_radius+eps, body_size[1]*mid_size_ratio[1]-edge_radius+eps]);
            translate([core_radius, mid_size_ratio[1]*body_size[1]]) square([mid_size_ratio[0]*body_size[0]-core_radius, (1-mid_size_ratio[1])*body_size[1]-edge_radius]);
        }
        circle(edge_radius);
    }
    translate([bearing_mount_radius, 0, 0]) square([core_radius-bearing_mount_radius+eps, body_size[1]]);
}
module h_shape_body(body_size, rim_thickness, bolt_nut_length, mid_size_ratio, face_groove_size){
    rotate([180, 0, 0]) rotate_extrude()union(){    h_shape_body_profile(body_size, rim_thickness, bolt_nut_length, mid_size_ratio);
        core_outline_profile(bolt_nut_length);
    }
}
module h_shape_yoyo(body_size, rim_thickness, bolt_nut_length, mid_size_ratio, face_groove_size){
    difference(){
        h_shape_body(body_size, rim_thickness, bolt_nut_length, mid_size_ratio, face_groove_size);
        core_groove();
        core_hole(bolt_nut_length);
        if($preview) {
            translate([0, 0, - body_size[1]-eps]) cube([body_size[0], body_size[0], body_size[1]+bearing_width/2+2*eps]);
        }
        face_hole(body_size, rim_thickness, bolt_nut_length, face_groove_size);
    }
}


h_shape_yoyo(body_size, rim_thickness, bolt_nut_length, h_body_mid_size_ratio);

