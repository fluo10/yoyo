include <specs.scad>;
include <config.example.scad>;
include <../modules/BOSL2/std.scad>;
include <../modules/BOSL2/beziers.scad>;
include <../modules/BOSL2/rounding.scad>;

use <core.scad>;

function scale_bezier(size, bez) = [ for (i=bez) [i[0]*size[0], i[1]*size[1]]];
    
module curved_body_profile(body_size, rim_thickness, bolt_nut_length, bezier_body_control_points){

    bez=scale_bezier([body_size[0]-core_radius-edge_radius,body_size[1]-edge_radius*2] ,bezier_body_control_points);
    echo(bez);
    //points=bezpath_points(bez);
    curve_path=bezpath_curve(bez, N=len(bez)-1);
    face_path=[[body_size[0]-core_radius-edge_radius, body_size[1]-edge_radius*2], [0, body_size[1]-edge_radius*2], [0, 0]];
    path=path_join([curve_path, face_path]);
    difference() {
            union(){
            translate([core_radius,edge_radius, 0]) minkowski(){
                polygon(path);
                circle(edge_radius);
            }
            translate([bearing_mount_radius, 0, 0]) square([core_radius-bearing_mount_radius, body_size[1]]);
            core_outline_profile(bolt_nut_length);
        }
        core_groove_profile();
    }
}

module curved_body(body_size, rim_thickness, bolt_nut_length, bezier_body_control_points) {
    rotate([180,0, 0]) rotate_extrude()  curved_body_profile(body_size, rim_thickness, bolt_nut_length, bezier_body_control_points);
}

curved_body(body_size, rim_thickness, bolt_nut_length, curved_body_control_points);
