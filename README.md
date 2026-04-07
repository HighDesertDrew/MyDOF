# MyDOF
My Degrees of Freedom - Multi-language ballistic programs

The programs here are for learning about trajectory calculations, at the moment, most of this is proof of concept
for code I've written and re-written dozens of times, but I want to not lose it this time. Also, I've had a lot of questions
about how ballistics actually works.

Like any complex mathematical prediction system, these programs break a trajectory in a gravity field up into a number of discrete elements, performs calculations, makes a prediction, and then does it again based on that previous prediction. The code and examples here use entirely SI (metric) units so everything is in meters, seconds, (kilo)grams. If desired, converting from metric to FPS (Feet/Pound/Second) can be done as an additional function, however the math is just easier to understand in metric.

Everything here is chicken scratch back of napkin code. I went for simple, easy to understand algorithms. Constants are declared in the header, so if you needed to re-use the code here for understanding ballistics on the moon, mars, or titan, you just need to adjust the constants.

Directories and Versions
cDOF - C/C++ versions (fastest)
PerlDOF - Perl versions (about 30x slower) - This is where the algorithm development happens. Functions then re-written in C and Python
PyDOF - Python versions (about 50-70x slower)

As of this version, drag functions are not implemented. 


Brought to you by Carl's Jr.
