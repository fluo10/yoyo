include <config.scad>;
use <../../round_body.scad>;
use <../../bowl_face.scad>;
use <../../core.scad>;
use <../../curved_body.scad>;

difference(){
    round_body(body_size, rim_thickness, bolt_nut_length);
    bowl_face_hole(body_size, rim_thickness, bolt_nut_length);
    core_hole(bolt_nut_length);
}