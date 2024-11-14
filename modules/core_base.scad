include <global_variables.scad>;

pad_groove_outer_radius=9.6;
pad_groove_inner_radius=7.2;
pad_groove_depth=1;
bearing_groove_outer_radius=6.5;
bearing_groove_mid_radius=4.5;
bearing_groove_inner_radius=3.125;
bearing_groove_min_depth=bearing_mount_offset;
bearing_groove_max_depth=pad_groove_depth;


module core_profile() {

    module base() {
            translate([0, pad_groove_depth, 0]) square( [core_radius, core_thickness - pad_groove_depth]);
    }
    module outer_wall() {
        radius=core_radius - pad_groove_outer_radius;
        translate([core_radius, pad_groove_depth, 0]) rotate([0, 0, 180]) square([radius, pad_groove_depth]);
    }
    module inner_wall() {
        thickness=pad_groove_inner_radius - bearing_groove_outer_radius;
        translate([bearing_groove_outer_radius, 0, 0]) square([thickness, core_thickness]);

    }
    module center_bump() {
        translate([0, -core_center_bump_height, 0]) square([bearing_groove_inner_radius, core_thickness]);
    }
    module bearing_groove() {
        translate([0, bearing_groove_min_depth, 0]) square([bearing_groove_mid_radius, core_thickness-bearing_groove_min_depth]);
    }
        
        
    union() {
        base();
        outer_wall();
        center_bump();
        inner_wall();
        bearing_groove();
    }
}
//core_plane();

module core_base() {
    rotate([0, 90, 0]) rotate_extrude() core_profile();
}
    
difference() {
    core_base();
    translate([-core_center_bump_height, 0, 0]) cube([core_center_bump_height + core_thickness, core_radius, core_radius]);
}
//pad_hole();
//bearing_hole();