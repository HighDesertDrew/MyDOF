#!/usr/bin/perl

use strict;
use Math::Trig;
use lib '.';
require "functions.pl";

my $vel = 1000; #m/s
my $angl = .005; #5 MIL
my $grav = 9.807; #m/s


my($xpos,$ypos);

#test functions

#my $hyp = &magnitude(3,4);
#print "Hype: $hyp\t";
#my($xvelo,$yvelo) = &vectorize(10,(pi()/4));
#print ("Vectorize: $xvelo, $yvelo\t");
#my($angle) = &findangle($xvelo,$yvelo);
#print ("Angle (rad): $angle\n");

# The goal is to determine the time interval based on the velocity, this is agnostic of the angle, since we know the launch angle (or should) 
# we can then vectorize the components, and apply the gravity function over that time. The interval should be short, say 10cm or so. Since everything internally
# is calculated in metric units the step is .010m in this way the system will actually be calculating the length of the trajectory, not just the x-component

#For this to work, it will have to calculate the TOF per interval, the x,y components of it, subtract acceleration from gravity from the y-component
# and then recalculate the velocity and the angle of attack. 
#

#Range = (Initial Velocity² * sin(2 * Launch Angle)) / g

my $range = ($vel ** 2) * sin(2*$angl) / $grav;
print "Sanity Check Range = $range\n";

my($time,$xvel,$yvel,$tof,$gravity);
my $prevel = $vel;
my $aoa = $angl;
my $count;

do
 {
  $time = .001 / $prevel; #.010 or 10cm is the chosen interval of the arc. 
  $tof += $time;
  ($xvel,$yvel) = &vectorize($prevel,$aoa);
  $gravity = $grav * $time;
  $yvel -= $gravity;
  $aoa = &findangle($xvel,$yvel);
  $prevel = &magnitude($xvel,$yvel); # - (&finddrag($prevel) * $time);

  $xpos += $xvel * $time;
  $ypos += $yvel * $time;
  #if (!($count % 1000)) { printf("%d = %3.3f, %3.3f\t%3.3f %3.3f %3.3fMIL %3.3f\n",$count,$xpos,$ypos,$prevel,$gravity,($aoa*1000),$tof); }
  $count++;
 } while ($ypos > 0);

print "Final Results:\n";
printf("%d = %3.3f, %3.3f\t%3.3f %3.3f MIL TOF%3.3f\n",$count,$xpos,$ypos,$prevel,($aoa*1000),$tof);

