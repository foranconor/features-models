
steel = "DarkSlateGray";
timber = "BurlyWood";
alpha = 1;

module blockTread(width, depth, thickness, radius) {
  color(timber, alpha) {
  difference() {
    hull() {
      for (i = [-1, 1]) {
        for (j = [-1, 1]) {
          for (k = [-1, 1]) {
            translate([i * width/2-radius * i, j*depth/2-radius *j, k *thickness/2-radius * k]) {
              sphere(radius);
              
            }
          }
        }
      }
    }
    hull() {
      for (i = [-1, 1]) {
        for (j = [-1, 1]) {
          translate([i * 604/2, j * 204/2, -thickness/2-7]) {
            cylinder(h=13, r=8);
          }
        }
      }
    }
  }
}
}

module rre(x, y, radius, length) {
  hull() {
    for (i = [-1, 1]) {
      for (j = [-1, 1]) {
        translate([i * (x/2 - radius), j * (y/2 - radius), 0]) {
          cylinder(h=length, r=radius);
        }
      }
    }
  }
}

module rhs(x,y,radius,wall,length) {
  color(steel, alpha) {
    difference() {
      rre(x, y, radius, length);
      translate([0,0,-1]) {
        rre(x-wall, y-wall, radius, length + 2);    
      }
    }
  }
}

module plate(x, y, z, radius) {
  color(steel, alpha) {
    difference() {
      rre(x, y, radius, z);
      for (i = [-1, 1]) {
        for (j = [-1, 1]) {
          translate([i*(x/2-3*radius), j*(y/2-3*radius), -1]) {
            cylinder(h=z + 2, r=6);
          }
        }
      }
    }
  }
}



module cutRhs(x, y, radius, wall, length, a, b) {
  difference() {
    rhs(x, y, radius, wall, length);
    translate([-x/2,0, x*tan(a)]) {
      rotate([0, a, 0]) {
        translate([x, 0, -x]) {
          cube([x*2,y+2,x*2], center=true);
        }
      }
    }  
    translate([x/2,0,length]) {
      rotate([0, -b+180, 0]) {
        translate([x, 0, -x]) {
          cube([x*2,y+2,x*2], center=true);
        }
      }
    }      
  }
}

