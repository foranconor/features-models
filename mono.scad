use <components.scad>

module straight(going, rise, steps, width) {
  totalRise = rise * steps;
  angle = atan(rise/going);
  
  totalGoing = going * steps;
  hypot = sqrt(totalGoing * totalGoing + totalRise * totalRise);
  px = 600;
  py = 255;
  pz = 10;
  pr = 10;
  epy = 400;
  
  // bottom plate
  translate([0, py/2, 0]) {
    plate(px, py, pz, pr);
  }
  // top plate
  translate([0, totalGoing, totalRise - py/2]) {
    rotate([90, 0, 0]) {
      plate(px, py, pz, pr);
    }
  }
  sx = 120;
  sy = 90;
  
  // short on bottom side
  theta = 90 - angle;
  bcf = sx / cos(theta);
  a = tan(theta) * pz;
  b = ((py - bcf)/2 - a) * sin(theta);
  // short on the top side
  tcf = sx / cos(angle);
  c = tan(angle) * pz;
  d = ((py - tcf)/2 - c) * sin(angle);
  echo(b);
  echo(d);
  
  rhsLength = hypot - b- d;
  
  // string
  translate([0, py/2, pz]) {
    rotate([-(90-angle), 0, 0]) {
      translate([0, 0, -tan(90-angle)*sx/2]) {
        rotate([0, 0, -90]) {
          cutRhs(sx, sy, 10, 10, rhsLength, 90-angle, angle);
        }
      }
    }
  }
  
  // upstands
  ua = angle;
  ux = 90;
  uy = 64;
  ul = 120;
  ubcf = ux / cos(angle-ua);
  echo(ubcf);
  for (i = [0:steps-1]) {
    translate([0, py/2+(i * going), pz+bcf/2*tan(angle)+(i*rise)]) {
      rotate([ua, 0, 0]) {
        translate([0, 0, -tan(angle-ua)*ux/2]) {
          rotate([0, 0, -90]) {
            cutRhs(ux, uy, 10, 10, ul, angle-ua, ua);
          }
        }
      }
    }
    drop = ubcf/2*sin(angle);
    raise = ul*cos(ua);
    fwd = (raise - drop) * tan(ua);
    plateHeight = pz+bcf/2*tan(angle) - drop + raise;
    translate([0, py/2 + (i*going) - fwd, plateHeight + (i*rise)]) {
      plate(px, 200, 10, 10);
    }
    translate([0, py/2 - fwd + (i*going), plateHeight - pz + 3 + 90/2 + (i*rise)]) {
      blockTread(width, going+25, 80, 6);
    }
  }
  
}


