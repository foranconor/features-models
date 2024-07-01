use <components.scad>

timber = "BurlyWood";
maxGap = 40;
// just on stair
module stairBalustrade(length, bx, by, height, angle) {
  n = ceil(length / (by + maxGap));
  gap = (length - (n * by)) / (n - 1);
  hypot = length / cos(angle);
  for (i = [0:n-1]) {
    translate([0, i * (by+gap), i * tan(angle) * (by + gap)]) {
      baluster(bx, by, height, angle, angle);
    }
  }
  translate([0, 0, height]) {
    rotate([-(90-angle), 0 ,0 ]) {
      rail(bx + 10, 42, hypot);
    }
  }
}

//stairBaluster(3500, 64, 42, 1200, 35);

// floor to stair
module floorToStairBalustrade(length, bx, by, height, angle) {
  n = ceil(length / (by + maxGap));
  gap = (length - (n * by)) / (n - 1);
  hypot = length / cos(angle);
  for (i = [0:n-1]) {
    translate([0, i * (by+gap), 42]) {
      baluster(bx, by, height + i * tan(angle) * (by + gap) - 42, 0, angle);
    }
  }
  translate([0, 0, height]) {
    rotate([-(90-angle), 0 ,0 ]) {
      rail(bx + 10, 42, hypot);
    }
  }
  translate([0, 0, 21]) {
    rotate([-90, 0 ,0 ]) {
      rail(bx + 10, 42, length);
    }
  }
}

//floorToStairBaluster(3500, 64, 42, 1200, 35);

// stair to roof
module stairToRoofBalustrade(length, bx, by, height, angle) {
  n = ceil(length / (by + maxGap));
  gap = (length - (n * by)) / (n - 1);
  for (i = [0:n-1]) {
    translate([0, i * (by+gap), i * tan(angle) * (by + gap)]) {
      baluster(bx, by, height - i * tan(angle) * (by + gap)-42, angle, 0);
    }
  }
  translate([0, 0, height-21]) {
    rotate([-90, 0 ,0 ]) {
      rail(bx + 10, 42, length);
    }
  }
    
}

//stairToRoofBaluster(3500, 64, 42, 4200, 35);


// floor to roof
module floorToRoofBalustrade(length, bx, by, height) {
  n = ceil(length / (by + maxGap));
  gap = (length - (n * by)) / (n - 1);
  for (i = [0:n-1]) {
    translate([0, i * (by+gap), 42]) {
      baluster(bx, by, height-84, 0, 0);
    }
  }
  translate([0, 0, height-21]) {
    rotate([-90, 0 ,0 ]) {
      rail(bx + 10, 42, length);
    }
  }
  translate([0, 0, 21]) {
    rotate([-90, 0 ,0 ]) {
      rail(bx + 10, 42, length);
    }
  }
    
}
//floorToRoofBaluster(3500, 64, 42, 3500);


module baluster(x, y, length, a, b) {
  color(timber, 1) {
  difference() {
    rre(x,y,3,length);
    translate([0,0,0]) {
        rotate([a, 0, 0]) {
          translate([0, 0, -x+y/2*tan(a)]) {
            cube([x*2,x*2,x*2], center=true);
          }
        }
      }  
      translate([0,0,length]) {
        rotate([b, 0, 0]) {
          translate([0, 0, x-y/2*tan(b)]) {
            cube([x*2,x*2,x*2], center=true);
          }
        }
      }  
    }
  }
}

module rail(width, thickness, length) {
  color(timber, 1) {
    translate([0, 0, -40]) {
      rre(width, thickness, 6, length+80);
    }
  }
}

