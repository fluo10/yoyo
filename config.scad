core_radius=10;
core_min_thickness=2;

body_radius=28;
body_width=22;

round_body_rim_thickness=10;
bearing_width=4.762;

eps=0.01;

bearing_mount_depth=0.15;
bearing_mount_protrude_length=bearing_width/2;
bearing_mount_radius=4.2;

width=body_width*2+bearing_width-bearing_mount_depth*2;

bearing_center_offset=-bearing_width/2+bearing_mount_depth;
edge_radius=1;

$fn=180;


weight_outer_radius=sqrt(body_radius^2 + body_width^2);
weight_layer_thickness=15;
weight_inner_radius=weight_outer_radius-weight_layer_thickness;

// Bolted core
bolt_body_length=20;
nut_thickness=5;
bolt_nut_interval_length=bolt_body_length-nut_thickness;
bolt_hole_length=bolt_nut_interval_length/2+nut_thickness;
bolt_hole_body_length=bolt_nut_interval_length/2;
bolt_hole_head_length=bolt_hole_length - bolt_hole_body_length;

face_center_width=bolt_hole_length-bearing_mount_protrude_length;

face_curve_bottom_radius=9;
face_curve_bottom_width=7;
center_edge_radius_max=edge_radius/2;
center_edge_radius_min=edge_radius/4;

