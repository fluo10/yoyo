include <specs.scad>;
use <core.scad>;
use <face.scad>;

module round_body_profile(body_size, rim_thickness, bolt_nut_length) {

    module base() {
        union() {
            minkowski(){
                translate([core_radius-eps, body_size[1]-edge_radius, 0]) resize([body_size[0]-core_radius-edge_radius+eps, body_size[1]-edge_radius*2]) rotate([180, 0, 0]) intersection(){
                    square(1);
                    circle(1);
                }
                circle(edge_radius);
            }
            translate([bearing_mount_radius, 0, 0]) square([core_radius-bearing_mount_radius, body_size[1]]);
        }
        
    }


    difference() {
        union(){
            base();
            //rim();
            core_outline_profile(bolt_nut_length);
        }
        core_groove_profile();
    }
}
module round_body(body_size, rim_thickness, bolt_nut_length) {
    rotate([180, 0, 0]) rotate_extrude() round_body_profile(body_size, rim_thickness, bolt_nut_length);
}
module round_yoyo(body_size, rim_thickness, bolt_nut_length) {
    difference() {
        round_body(body_size, rim_thickness, bolt_nut_length);
        core_hole(bolt_nut_length);
        face_hole(body_size, rim_thickness, bolt_nut_length, face_groove_size);
    }
}


difference() {
    round_body(test_body_size, test_rim_thickness, test_bolt_nut_length);
    translate([0, 0, - test_body_size[1]-eps]) cube([test_body_size[0], test_body_size[0], test_body_size[1]+bearing_width/2+eps*2]);
};
