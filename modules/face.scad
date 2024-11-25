include <specs.scad>;
use <core.scad>;

function face_curve_bottom_radius(body_radius, rim_thickness)=(body_radius - rim_thickness + bearing_mount_radius*2)/3;
function face_curve_bottom_width(bolt_body_length,nut_thickness)=face_center_width(bolt_body_length, nut_thickness)-1;

module fan(size) {
    resize(size) intersection(){
        circle(1);
        square(1);
    }
}
module reverse_fan(size) {
    resize(size) difference(){
        square(1);
        circle(1);
    }
}
    

module face_hole_profile(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, face_groove_size) {
    center_width=face_center_width(bolt_body_length, nut_thickness);
    
    module face_inner_curve() {
        translate([face_curve_bottom_radius(body_radius, rim_thickness), face_center_width(bolt_body_length, nut_thickness)-center_edge_radius_min]) resize([face_curve_bottom_radius(body_radius, rim_thickness)-bearing_mount_radius-center_edge_radius_max, face_center_width(bolt_body_length, nut_thickness)-face_curve_bottom_width(bolt_body_length, nut_thickness)-center_edge_radius_min]) rotate([0,0,  180])  intersection() {
            circle(1);
            square(1);
        }
        translate([face_curve_bottom_radius(body_radius, rim_thickness), face_center_width(bolt_body_length, nut_thickness)-center_edge_radius_min,0]) rotate([0, 180, 0])square([face_curve_bottom_radius(body_radius, rim_thickness)-bearing_mount_radius-center_edge_radius_max, body_width]);
        
    }
    module half_hole(size){
        size_with_edge=[size[0]+edge_radius, size[1]+edge_radius];
        echo(size)
        rotate([0, 0, 270]) difference(){
            square([size[1]+edge_radius, size[0]+edge_radius]);
            minkowski(){
                translate([edge_radius, 0, 0]) reverse_fan([size[1]+0, size[0]+edge_radius]);
                circle(edge_radius);
                
            }
        }
            
    }


    if(!face_groove_size) {
        translate([bearing_mount_radius-eps, body_width+eps ]) half_hole([body_radius-rim_thickness-bearing_mount_radius+eps,body_width-face_center_width(bolt_body_length, nut_thickness)+eps]);

        
    } else {
        union(){
            face_inner_curve();
            face_outer_curve();
        }
    }
}
module face_hole(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, face_groove_size) {
    rotate([180, 0,0]) rotate_extrude() face_hole_profile(body_radius, body_width, rim_thickness, bolt_body_length, nut_thickness, face_groove_size);
}
face_hole_profile(
    body_radius=30,
    body_width=20,
    rim_thickness=10, 
    bolt_body_length=20,
    nut_thickness=3,
    face_groove_size=[]
);