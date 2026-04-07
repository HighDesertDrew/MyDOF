
sub magnitude
 {
  my $x = shift;
  my $y = shift;
  my $mag = sqrt(($x ** 2) + ($y ** 2));
  #print ("Magnitude $mag of $x + $y\n");
  return $mag;
 }

sub vectorize
 {
  my $velo = shift;
  my $angle = shift;
  my $xvel = $velo * cos($angle);
  my $yvel = $velo * sin($angle);
  return($xvel,$yvel);
 }

sub findangle
 {
  my $x = shift;
  my $y = shift;
  my $angle = atan($y/$x);
  return ($angle);
 }

sub finddrag
 { 
  my $vel = shift;
  $vel = ($vel ** .5);
  return $vel;
 }

sub degtorad
 {
  my $angle = shift;
  $angle = $angle * (pi()/180);
  return $angle;
 }

sub uphill
 {
  my $angle = shift;
  my $distance = shift;
  my $groundlevel = $distance * tan($angle);
  return $groundlevel;
 }



return 1;
