include <config.scad>;
use <modules/core.scad>;
module weight() {
    module rim_profile() {
        module base() {
            translate([0, -bearing_mount_protrude_length, 0]) square([body_radius, body_width+bearing_mount_protrude_length]);
        }
        module hollow() {
            difference(){
                circle(weight_outer_radius);
                circle(weight_inner_radius);
            }
        }
        intersection() {
            base();
            hollow();
        }
            
    }
    
    rotate([180, 0, 0]) rotate_extrude() {
       
            rim_profile();
            core_outline_profile();
           }
}
weight();