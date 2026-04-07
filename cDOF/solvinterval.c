#include <stdio.h>
#include <math.h>



double magnitude(double x, double y)
 {
  return sqrt(pow(x,2) + pow(y,2)); 
 }

double findangle(double x, double y) //takes x,y returns the angle of the composite in radians
 {
  return atan(y/x);
 }


void main()
 {
  double vel = 1000; //m/s
  double angl = .005; //5 MIL
  double max = 100; //m Did I use this?
  double grav = 9.807; //m/s

  double xpos=0,ypos=0;
  double time=0,xvel=0,yvel=0,tof=0,gravity=0,prevel=0,aoa=0;
  long unsigned count = 0;


  prevel = vel;
  aoa = angl;
  do {
    time = .001 / prevel; //.010 or 10cm is the chosen interval of the arc. 
    tof += time; //this just accumulates the time of flight
    //($xvel,$yvel) = &vectorize($prevel,$aoa);
    xvel = prevel * cos(aoa);
    gravity = grav * time;
    yvel = (prevel * sin(aoa)) - gravity;
    aoa = findangle(xvel,yvel);
    prevel = magnitude(xvel,yvel); //- (&finddrag($prevel) * $time);

    xpos += xvel * time;
    ypos += yvel * time;
  //if (!(count % 1000)) { printf("%d = %3.3f, %3.3f\t%3.3f %3.3f %3.3fMIL %3.3f\n",count,xpos,ypos,prevel,gravity,(aoa*1000),tof); }
    count++;
 } while (ypos > 0);

printf("Final Results:\n");
printf("%lu = %3.3lf, %3.3lf\t%3.3lf %3.3lf MIL TOF%3.3lf\n",count,xpos,ypos,prevel,aoa,tof);

 } // end of main()
