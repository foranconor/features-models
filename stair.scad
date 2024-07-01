use <mono.scad>
use <glass.scad>
use <baluster.scad>

$fn = 6;
going = 255;
rise = 180;
steps = 15 ;
height = 1100;
width = 1200;

straight(going, rise, steps, width);


// glass
translate([-width/2 - 50, -50, 17]) {
  difference() {
    //glass(height, going, rise, steps);
    //cube([width, width, 250], center=true);
  }
}

// balusters
translate([-width/2-32, 0, 0]) {
  tg = going * steps;
  angle = atan(rise/going);
  bx = 64;
  by = 42;
  stairBalustrade(tg, bx, by, height, angle);
  //floorToStairBalustrade(tg, bx, by, height, angle);
  //stairToRoofBalustrade(tg, bx, by, 4000, angle);
  //floorToRoofBalustrade(tg, bx, by, 4800);
}

//wall 
color("SlateGray", 1){
  translate([width/2+5, 0, 0]) {
    cube([90, going * steps, 3600]);
  }
}