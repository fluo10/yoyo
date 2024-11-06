module body_profile() {
    union() {
        square(5);
    }
}
module body() {
    rotate_extrude() body_profile();
}
translate([0, 0, 0]) body_profile();