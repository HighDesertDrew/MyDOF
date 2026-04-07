import math

velocity = 1000

grav = 9.8

#LA is in milirad
LA = 50
LA = LA / 1000

yvel = math.sin(LA) * (velocity)
xvel = math.cos(LA) * velocity

print(xvel)
print(yvel)

ypos = 0
xpos = 0
gravec = 0


for time in range(1000):
	mt = time/1000
	gravec = gravec + (grav * mt ** 2)/2
	ypos = ypos + (yvel * .001) - (grav * mt ** 2)/2
	xpos = xpos + (xvel * .001)
	if ((time % 100) == 0): 
		print(f'{mt:10}: {xpos:10} ==> {ypos:10} {gravec:10}')
	if (ypos < 0): 
		print(f'{mt:10}: {xpos:10} ==> {ypos:10} {gravec:10}')
		break;
 