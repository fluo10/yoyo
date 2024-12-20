include <specs.scad>;
use <core.scad>;

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
    

module bowl_face_hole_profile(body_size, rim_thickness, bolt_nut_length) {
    center_width=face_center_width(bolt_nut_length);
    
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

    translate([bearing_mount_radius-eps, body_size[1]+eps ]) half_hole([body_size[0]-rim_thickness-bearing_mount_radius+eps,body_size[1]-face_center_width(bolt_nut_length)+eps]);

}
module bowl_face_hole(body_size, rim_thickness, bolt_nut_length) {
    rotate([180, 0,0]) rotate_extrude() bowl_face_hole_profile(body_size, rim_thickness, bolt_nut_length);
}
bowl_face_hole_profile(
    body_size=test_body_size,
    rim_thickness=test_rim_thickness, 
    bolt_nut_length=test_bolt_nut_length
);