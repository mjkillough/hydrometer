$fn = 100;

w = 30;
h = 122;
d = 8;
// depth of shelf
dshelf = 6;
edge = 2;

// buffer around parts for tolerance
b = 0.5;

// width/height of d1
wd1 = 25 + (2 * b);
hd1 = 34 + b;
// width/height of charger
wcharger = 17 + b;
hcharger = 29 + b;
// radius/height of battery
rbat = 9;
hbat = 66 + (2 * b);
// width/height of d1


module charger() {
    w = wcharger;
    h = hcharger;
    // cutout for feet
    wcutout = 11;
    hcutout = 2;
    // feet (i.e. either side of cutout)
    wfeet = 3;
    // usb
    wusb = 7 + (3 * b);
    husb = 4;
    
    translate([0, 0, d - dshelf]) {
        difference() {
            // base
            cube([w, h, dshelf]);

            // cutout for feet, 3mm either side
            // -1, -1 to oversize for difference
            translate([wfeet, 0, 0])
            cube([wcutout, hcutout, dshelf]);
        }

        // usb
        translate([(w - wusb) / 2, h - (husb / 2), 0])
        cube([wusb, husb, dshelf]);
    }
}

module d1() {
    // width and height of board
    w = wd1;
    h = hd1;
    // width of shelf
    wshelf = 1;
    // height of window for reset switch
    hreset = 7;
    // width the reset switch needs to 
    // extend outside by
    wreset = wshelf * 5;
    
    // top, to make sides
    translate([0, 0, (d - dshelf)])
    cube([w, h, dshelf]);

    // bottom, to cut between shelves
    translate([wshelf, 0, 0])
    cube([w - (wshelf * 2), h, d]); 
    
    // reset switch
    translate([w - wshelf, h - hreset, 0])
    cube([wreset, hreset, d]);
}

module sled() {
    // radius of rounded corner
    r = 9;

    hull() {
        translate([0, r, 0])
        cube([w, h - r, d]);

        translate([r, r, 0])
        cylinder(r = r, h = d);

        translate([w - r, r, 0])
        cylinder(r = r, h = d);
    }
}

module battery() {
    r = rbat;
    h = hbat;
    
    translate([r, 0, r])
    rotate([-90, 0, 0])
    cylinder(r = r, h = h);
}

// edge either side of battery
edgeb = (w - (rbat * 2)) / 2;

module clips() {
    wb = 3;
    hb = 5;
    from_side = (edgeb - 3) / 2;
    
    translate([from_side, 0, 0])
    cube([wb, hb, d]);
    
    translate([w - from_side - wb, 0, 0])
    cube([wb, hb, d]);

}

difference() {
    sled();
    
    translate([(w - wd1) / 2, h - hd1, 0])
    d1();
    
    translate([hcharger + 1.5, h - hd1 - wcharger - 1, 0])
    rotate([0, 0, 90])
    charger();
    
    translate([edgeb, 1, .5])
    rotate([1.5, 0, 0])
    battery();
    
    translate([0, 20, 0])
    clips();
}
