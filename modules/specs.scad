core_radius=10;
core_min_thickness=2;



round_body_rim_thickness=10;
bearing_width=4.762;

eps=0.01;

bearing_mount_depth=0.15;
bearing_mount_protrude_length=bearing_width/2;
bearing_mount_radius=4.2;

bearing_center_offset=-bearing_width/2+bearing_mount_depth;
edge_radius=1;

$fn=180;
function bolt_nut_interval_length(bolt_body_length, nut_thickness)=bolt_body_length-nut_thickness;

bolt_hole_body_margin=1;
function bolt_hole_body_length(bolt_body_length, nut_thickness)=bolt_nut_interval_length(bolt_body_length, nut_thickness)/2-bolt_hole_body_margin;

function bolt_hole_length(bolt_body_length, nut_thickness)=nut_thickness+bolt_hole_body_length(bolt_body_length, nut_thickness);

function face_center_width(bolt_body_length, nut_thickness)=bolt_hole_length(bolt_body_length, nut_thickness)-bearing_mount_protrude_length;



center_edge_radius_max=edge_radius/2;
center_edge_radius_min=edge_radius/4;
