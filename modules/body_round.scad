include <../config.scad>;


module round_body_profile() {
    module base() {
        intersection() {
            translate([core_radius, body_width-edge_radius, 0]) resize([ (body_radius-core_radius)*2 ,(body_width-edge_radius)*2, 0]) circle(100);
            translate([core_radius, 0, 0]) square([body_radius-core_radius, body_width-edge_radius]);
        }
    }
    module rim() {
        hull(){
            translate([body_radius-edge_radius, body_width-edge_radius,0]) circle(edge_radius);
            translate([body_radius-round_body_rim_thickness+edge_radius, body_width-edge_radius, 0]) circle(edge_radius);
        }
    }
    module inner_curve() {
        translate([core_radius, body_width, 0]) resize([(body_radius-round_body_rim_thickness-core_radius)*2, (body_width-core_thickness)*2, 0]) circle(100);
    }
    module core() {
        square( [core_radius, core_thickness]);
    }
    difference() {
        union(){
            base();
            rim();
        }
        inner_curve();
        core();
    }
}
module round_body() {
    rotate([0, 90, 0]) rotate_extrude() round_body_profile();
}
translate([0, 0, 0]) round_body_profile();
//translate([10, 0, 0]) round_body();