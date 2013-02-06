include <ucon_config.scad>
use <ucon_functions.scad>
use <MCAD/motors.scad>
use <MCAD/nuts_and_bolts.scad>
$fn=100;


rod_spacing = 24;
bearing_spacing = 12;
ballbearingOD = 5/32*25.4;
ballbearingTol = 0.1;
bushingOD = 15;

bushingL = 15.3;
echo(bushingL);
hotendsep = 11.65;
belt_h = 1.75;
belt_w = 6.5;
xoffset=10;

bearingOD = 13;
bearingID = 4;
bearingH = 5;

xendA();

/*difference(){
rotate([0,90,0])
union(){
translate([0,0,11/2-0.001]) xendB();
translate([0,0,-11/2]) rotate([0,180,0]) scale([-1,1,1]) xendB();}
mockbearing();
}

translate([3*11/2+3,-1,23]) rotate([0,0,90]) rotate([-90,0,0]) xendA();
translate([0,-1,12.5]) rotate([0,90,0]) cylinder(r=15/2,h=24);*/

module mockbearing(){
union(){
union(){
translate([-5.5,-2,13.05]) cube([11.05,16+5.1,16+4.2],center=true);
//translate([-13.14,-2,8.55]) cube([bushingL+0.01-11,16+5.1,16+13.1],center=true);
}
translate([0,-2,0]) rotate([0,0,180])
union(){
translate([-5.5,0,13.05]) cube([11.05,16+5.1,16+4.1],center=true);
//translate([-13.14,0,8.55]) cube([bushingL-11,16+5.1,16+13.1],center=true);
}
translate([0,4,-1]) rotate([0,90,0]) cylinder(r=2.05,h=100,center=true);
translate([0,-6,-1]) rotate([0,90,0]) cylinder(r=2.05,h=100,center=true);}}

module xendA(mode=1){

difference(){
cross_sectionA();
rotate([0,0,90]) rodsnbushings(mode=mode);}

}

module cross_sectionA(){
difference(){
linear_extrude(height=bushingL)
minkowski(){
translate([0,14.5,0]) square([13,23],center=true);
circle(r=3.05);}
translate([-16/4-1,rod_spacing/2+16/2+4,-0.1]) cylinder(r=2+0.05,h=bushingL+1,center=false);
translate([16/4+1,rod_spacing/2+16/2+4,-0.1]) cylinder(r=2+0.05,h=bushingL+1,center=false);
//translate([0,3.5,-0.1]) cylinder(r=2+0.05,h=bushingL+1,center=false);
translate([-10,20,bushingL/2+1]) cube([20,20,bushingL]);
}}


module xendB(){
difference(){
union(){
difference(){
cross_sectionB(11);
rotate([0,0,180]) translate([-6.5,-25,5.6]) rotate([90,0,0]) rotate([0,0,90]) fillet(4,12);
translate([-xoffset-8-12/2-2,0,0]) rotate([90,0,0]) cylinder(r=2,h=20,center=true);
translate([0,15,-11/2]) rotate([0,90,0]) cylinder(r=4+0.05,h=50,center=true);
translate([0,35,-11/2]) rotate([0,90,0]) cylinder(r=4+0.05,h=50,center=true);
}

translate([0,25+2+12/2,11/2+bearingOD/2-0.01])
difference(){
rotate([0,0,180]) 
union(){
cube([12,4,bearingOD],center=true);
translate([0,-2,-6.5-0.1]) rotate([0,90,0]) fillet(5,12);}
translate([0,0,bearingOD/2-4]) rotate([90,0,0]) cylinder(r=2,h=10,center=true);}

translate([0,25-2-12/2,11/2+bearingOD/2-0.01])
difference(){
union(){
cube([12,4,bearingOD],center=true);
translate([0,-2,-6.5-0.1]) rotate([0,90,0]) fillet(5,12);}
translate([0,0,bearingOD/2-4]) rotate([90,0,0]) cylinder(r=2,h=10,center=true);}}

}}

module cross_sectionB(thickness,minkwid=4.5){
translate([0,0,-thickness/4])
minkowski(){
linear_extrude(height=thickness/2)
translate([-3.5,16,0]) square([10,46],center=true);
cylinder(r=minkwid,h=thickness/2,center=true);
}}

module rodsnbushings(mode=1){
translate([0,0,bushingL/2])
translate([rod_spacing/2-1.5,0,0]) cylinder(r=bushingOD/2,h=bushingL+0.05,center=true);
}

module fillet(rad,height){
translate([-rad,-rad,0])
difference(){
translate([0,0,-height/2]) cube([rad+0.01,rad+0.01,height]);
cylinder(h=height+1,r=rad,center=true);
}}