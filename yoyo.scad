include <config.scad>;
include <lib/specs.scad>;
use <lib/round_body.scad>;
use <lib/face.scad>;
use <lib/core.scad>;
use <lib/curved_body.scad>;

module yoyo_body(){
    if (shape=="round") {
        round_body(body_size, rim_thickness, bolt_nut_length);
    } else if (shape=="curved") {
        curved_body(body_size, rim_thickness, bolt_nut_length, curved_body_control_points);
    } else {
        assert(false, "Invalid shape!");
    }
}

module yoyo_face_hole() {
    if (face=="bowl") {
        bowl_face_hole(body_size, rim_thickness, bolt_nut_length, face_groove_size);
    } else if (face=="bump") {
        assert(false, "Unimplemented face_type!");
    } else {
        assert(false, "Invalid face_type!");
    }
}

difference(){
    yoyo_body();
    yoyo_face_hole();
    core_hole(bolt_nut_length);
    if ($preview) {
        translate([0,0,-body_size[1]-eps]) cube([body_size[0], body_size[0], body_size[1]+bearing_width/2+eps*2]);
    }
}
    
        
        
