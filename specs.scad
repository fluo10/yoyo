core_radius=10;
core_min_thickness=2;

bearing_radius=6.35;
bearing_width=4.762;

eps=0.01;

bearing_mount_depth=0.15;
bearing_mount_protrude_length=bearing_width/2;
bearing_mount_radius=4.2;

bearing_center_offset=-bearing_width/2+bearing_mount_depth;
edge_radius=1;

$fn=180;

test_body_size=[30, 20]; //[body_radius, body_width]
test_bolt_nut_length=[20, 3];//[bolt_length, nut_length]
test_weight_layer_thickness=15;
test_rim_thickness=10;
test_curved_body_control_points=[[0,0],[0.2, 0.2],[0.7, 0.3], [1, 0.4], [1,1]];

function bolt_nut_interval_length(bolt_nut_length)=bolt_nut_length[0]-bolt_nut_length[1];

bolt_hole_body_margin=0.2;
function bolt_hole_body_length(bolt_nut_length)=bolt_nut_interval_length(bolt_nut_length)/2-bolt_hole_body_margin;

function bolt_hole_length(bolt_nut_length)=bolt_nut_length[1]+bolt_hole_body_length(bolt_nut_length);

function face_center_width(bolt_nut_length)=bolt_hole_length(bolt_nut_length)-bearing_mount_protrude_length;

