#!/usr/bin/perl

use strict;
use Math::Trig;
use lib '.';
require "functions.pl";

my $vel = 1000; #m/s
#my $angl = .005; #5 MIL
my $zerod = 100;
my $max = 1000; #m

  
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

sub calctraj
 {
  my $zero = shift;
  my $vel = shift;
  my $startangl = shift;
  my $prec = shift;
  my $grav = 9.807; #m/s
  
#  my $range = ($vel ** 2) * sin(2*$angl) / $grav;
#  print "Sanity Check Range = $range\n";
  my($xpos,$ypos);
  my($time,$xvel,$yvel,$tof,$gravity);
  my $tryangl = $startangl;
  my $prevel = $vel;
  my $aoa;
  my $count;
  #we're going to try different angles until we get an $xpos ~ 0 then run it again with some precision
  while (($ypos < 0) || ($count == 0))
   {
    if ($xpos < ($zero/2)) { $tryangl *= 2; } 
    $tryangl += .0001; 
    $aoa = $tryangl;
    #reset counters
    $count = 0;
    $ypos = 0;
    $xpos = 0;
    $tof = 0;

    do
     {
      $time = $prec / $prevel; #.010 or 10cm is the chosen interval of the arc. 
      $tof += $time;
      ($xvel,$yvel) = &vectorize($prevel,$aoa);
      $gravity = $grav * $time;
      $yvel -= $gravity;
      $aoa = &findangle($xvel,$yvel);
      $prevel = &magnitude($xvel,$yvel); # - (&finddrag($prevel) * $time);

      $xpos += $xvel * $time;
      $ypos += $yvel * $time;
      $count++;
     } while (($xpos < $zero) && ($ypos > 0));
     
     #print "AOA: $tryangl\tXpos: $xpos\tYpos: $ypos\n";
    } #endd of while loop
   #printf("%d = %3.3f, %3.3f\t%3.3f %3.3f MIL TOF%3.3f\n",$count,$xpos,$ypos,$prevel,($tryangl*1000),$tof);
   return($count,$xpos,$ypos,$prevel,$tryangl,$tof);
 } #sub calctraj

print "Final Results:\n";
my($count,$xpos,$ypos,$prevel,$aoa,$tof) = &calctraj($zerod,$vel,0,.1);
my $zeroangle = $aoa;
printf("Zeroed at $zerod meters: %3.1f MIL TOF%3.3fs\n",($aoa*1000),$tof);
($count,$xpos,$ypos,$prevel,$aoa,$tof) = &calctraj($max,$vel,$zeroangle,.1);
printf("Firing Solution at $max meters: %3.1f MIL TOF%3.3fs\n",($aoa*1000),$tof);
my $adjust = $aoa - $zeroangle;
printf("Zero angle is: %1.1f MIL Come up %1.1fMIL\n",($zeroangle * 1000), ($adjust*1000));
#my $range = ($vel ** 2) * sin(2*$aoa) / 9.807;
#print "Sanity Check Range = $range\n";



