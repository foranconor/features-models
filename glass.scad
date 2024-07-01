use <components.scad>

glass = "MediumAquamarine";
standoffColor = "Silver";
timber = "BurlyWood";
glassMax = 1200;

module panel(angle, width, height) {
  
  
  color(glass, 0.3) {
  difference() {
    cube([12, width, height+width*tan(angle)]);
    translate([0,0,0]) {
      rotate([angle, 0, 0]) {
        translate([6, 0, -width]) {
          cube([14,width*4,width*2], center=true);
        }
      }
    }  
    translate([0,0,height]) {
      rotate([angle, 0, 0]) {
        translate([6, 0, width]) {
          
          cube([14,width*4,width*2], center=true);
        }
      }
    }  
  }
  }
}

module standoff(radius, length) {
  color(standoffColor, 0.8)
  translate([-12, 0, 0]) {
  rotate([0,90,0]) {
    
      cylinder(h=length, r=radius);
    }
  }
}

module handrail(width, thickness, length, radius) {
  color(timber, alpha=0.9) {
    translate([6, 0, -40]) {
      rre(width, thickness, radius, length+80);
    }
  }
}

module glass(height, going, rise, steps) {
  
  tg = going * steps; 
  tr = rise * steps;
  hypot = sqrt(tg*tg+tr*tr);
  gap = 10;
  panels = ceil(tg/glassMax);
  angle = atan(rise/going);
  panelSize = (tg - (panels - 1) * gap) / panels;
  for (i = [0:panels-1]) {
    translate([0, i*(panelSize + gap), i * (tan(angle)*(panelSize+gap))]) {
      panel(angle, panelSize, height); 
    }
  }
  
  for (i = [0:steps-1]) {
    translate([0, 70 + (i * going), rise + (i * rise)]) {
      standoff(20, 75);
    }
    translate([0, 0 + (i * going) + going - 70, rise + (i * rise)]) {
      standoff(20, 75);
    }
  }
  translate([0, 0, height]) {
    rotate([-(90-angle), 0, 0]) {
      handrail(64, 42, hypot, 6);
    }
  }
}


//panel(35, 1200, 1100);
//standoff(20, 75);
//handrail(64, 42, 1000, 6);