use <modules/body_round.scad>;
use <modules/core_threaded.scad>;
use <modules/core_bolted.scad>;

body_type="r"; // "r": round shape, "h": h-profile
core_type="b"; //"b": bolt-nut, "t": threaded
$fn=128;
module body(body_type) {
    if (body_type=="r") {
        round_body();
    } else {
        assert(false, "Invalid value");
    }
}
module core(core_type) {
    if (core_type=="b") {
        bolted_core();
    } else {
        assert(false, "Invalid value");
    }
}
union(){
    body(body_type);
    core(core_type);
}

