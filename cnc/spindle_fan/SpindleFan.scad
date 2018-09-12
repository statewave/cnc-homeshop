/* vim: ts=2 */
/*
*  Open SCAD Name.: CNC_Bit_Fan_v1.SCAD
*  Copyright (c)..: 2017 www.DIY3DTech.com
*  Copyright (c)..: 2018 Statewave
*
*  Creation Date..: 06/04/2017
*  Description....: CNC bit cooling and debris fan
*
*  Rev 1: Develop Model
*  Rev 2: Add cutout for the collet nut
*  Rev 3: ...
*
*  This program is free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  This code is supplied "as is" and high speed parts are dangerous
*  meaning the use of this is at YOUR OWN RISK!  
*
*/ 

/*------------------Customizer View-------------------*/

// preview[view:north, tilt:top]

/*---------------------Parameters---------------------*/

bit_dia         =   26.0;         // bit hole dia in mm
collet_dia      =   35.0;         // vertex to vertex diameter of hex for the collet nut

fan_dia         =   75.0;         // fan dia in mm
fan_height      =    9.0;         // height of fan

blade_count     =      9;         // blade count for fan 
blade_angle     =     45;         // angle in degrees

nozzle_dia      =    0.4;         // nozzle dia in mm
shell_count     =    6;           // number of shell to print

fragment_count  =     90;         // number of fragments fn$

// Insert Bit from top of fan

/*-----------------------Execute----------------------*/

main_module();

/*-----------------------Modules----------------------*/

module main_module() {
  difference() {
    union() {
      // create the outer ring
      ring_module();

      // create inner-ring next to spindle/bit
      translate ([0,0,0])
        rotate ([0,0,0])
        cylinder(fan_height, bit_dia * 0.7,bit_dia * 0.7,
                 $fn=fragment_count, true);

      // Loop to create blades
      for (theta=[0:(360/blade_count):360]) {
        x = 0+(fan_dia/4)*cos(theta);
        y = 0+(fan_dia/4)*sin(theta);
        translate([x,y,0])
          rotate([blade_angle,0,theta])
          cube([(fan_dia/2)-0.7, 1.2, fan_height+3.5], true);
      }
    }

    // subtraction of difference
    union() {
      // create tappered hole opening for bit
      translate ([0,0,0])
        rotate ([0,0,0])
        cylinder(fan_height+0.5, (bit_dia/2), (bit_dia/2),
                 $fn=fragment_count, true);

      // create hole shaped like the collet nut
      translate ([0,0,0])
        rotate ([0,0,0])
        nut();

      // trim the top of the blades
      translate([0,0,(fan_height+1.2)/2])
        rotate ([0,0,0])
        cube([(fan_dia*2), (fan_dia*2), 1.2], true);

     // trim the bottom of the blades
     translate([0,0,-(fan_height+1.2)/2])
        rotate ([0,0,0])
        cube([(fan_dia*2), (fan_dia*2), 1.2], true);
    }
  }
}

module ring_module() {
  
  d = ((fan_dia-(nozzle_dia*shell_count))/2);
 
  difference() {
    translate ([0,0,0])
      rotate ([0,0,0])
      cylinder(fan_height, fan_dia/2, fan_dia/2, $fn=fragment_count, true);

    translate ([0,0,0])
      rotate ([0,0,0])
      cylinder(fan_height+0.5, d, d, $fn=fragment_count, true);
    }
}

module nut() {
  cylinder(h = fan_height*0.6, r=(collet_dia / 2), $fn=6);
}

/*----------------------End Code----------------------*/
