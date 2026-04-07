#!/usr/bin/perl

use strict;
use Math::Trig;
use lib '.';
require "functions.pl";

my $vel = 1000; #m/s
my $angl = .005; #5 MIL
my $max = 100; #m
my $grav = 9.807; #m/s
my $upangle = 7;

my($xpos,$ypos,$groundlevel);
my($time,$xvel,$yvel,$tof,$gravity);
my $prevel = $vel;
my $aoa = $angl + &degtorad($upangle);
my $count;

do
 {
  $time = .001 / $prevel; # The number is the length we'll be calculating everything for
  $tof += $time;
  ($xvel,$yvel) = &vectorize($prevel,$aoa);
  $gravity = $grav * $time;
  $yvel -= $gravity;
  $aoa = &findangle($xvel,$yvel);
  $prevel = &magnitude($xvel,$yvel) - (&finddrag($prevel) * $time);

  $xpos += $xvel * $time;
  $ypos += $yvel * $time;
  if (!($count % 1000)) { printf("%d = %3.3f, %3.3f\tGround: %3.3f %3.3fMIL %3.3f\n",$count,$xpos,$ypos,&uphill(&degtorad($upangle),$xpos),($aoa*1000),$tof); }
  $count++;
 } while ($ypos > &uphill(&degtorad($upangle),$xpos));

print "Final Results:\n";
printf("%d = %3.3f, %3.3f\t%3.3f %3.3f MIL TOF%3.3f\n",$count,$xpos,$ypos,$prevel,($aoa*1000),$tof);

