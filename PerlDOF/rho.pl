#!/usr/bin/perl

use strict;


sub Pvant #Antoine Equation for Pv
 {
  my $temp = shift;
  my $exp = 8.07131 - (1730.63/(233.426+$temp));
  print "EXP: $exp\n";
  my $Pressure = ((10 ** $exp) * 133.322);
  return $Pressure;
 }

sub Pmagnus
 {  #6.112 · exp(17.67T/(T+243.5))
  my $temp = shift;
  my $pres = 6.112 * exp((17.67 * $temp)/($temp + 243.5));
  $pres *= 100; #from kPa to hPa
  return $pres;
 }

sub Ptetens
 {  #above freezing
  my $temp = shift;
  my $pres = 6.1078 * exp((17.27 * $temp)/($temp + 237.3));
  $pres *= 100; #convert from kPa to hPa
  return $pres;
 }

sub rho
 {
  my $tempinc = shift;
  my $rh = shift;
  my $baro = shift;
  $baro *= 100;
  #my $Rv = 461.495;
  #my $Rd = 287.058;
  #my $K = 273.15;
  #  pd = p − pv
  #pd/(RdT) + pv/(RvT)
  my $Pv = &Ptetens($tempinc);
  $tempinc += 273.15;
  my $Pd = $baro - $Pv;
  my $density = ($Pd/(287.058 * $tempinc)) + ($Pv/(461.495 * $tempinc));
  return $density;
 }

my $pV = &Pvant(0);
print "Pressure Antoine: $pV\n\n";

$pV = &Pmagnus(0);
print "Pressure Magnus: $pV\n\n";

$pV = &Ptetens(0);
print "Pressure Tetens: $pV\n\n";



my $density = &rho(0,50,1013.25);
print "$density kg/m^3\nShould be 1.18\n";
