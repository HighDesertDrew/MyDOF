import math
import tkinter as tk
from tkinter import *
root = Tk()
canvas = Canvas(root)

root.geometry("1000x600")
root.title("MyDOF")



velocity = 50 #m/s

grav = 9.8/2

#angle_label = tk.Label(root, text='Angle (deg)')
#angle_label.pack()
#angle_entry = tk.Entry(root)
#angle_entry.pack()



Angle_deg = 10
Angle_rad = math.pi * (Angle_deg / 180)
print(Angle_rad)
#LA is in milirad
LA = Angle_rad 
#LA = 0.174532925
#LA = LA * 1000

yvel = math.sin(LA) * (velocity)  #vector velocity of Y
xvel = math.cos(LA) * velocity    #vector velocity of X

print(xvel)
print(yvel)

ypos = 0
xpos = 0
xposwas = 0
yposwas = 0
time = 0
aoa = 0

screen=Canvas(root, width=1000,height=500,bg="black")
screen.pack()
screen.create_line(10, 465, 980, 465, width=10, fill="green")
canvas.pack()

vscale = 5
hscale = 5


#for time in range(6000):
while True:
	time += 1
	mt = time/1000 #this allows it to tick in milliseconds
	
	yvel = yvel - (grav * .001) #we recalculate Y velocity as v = u + at however a is G which is negative

	ypos = ypos + (yvel * .001)
	xpos = xpos + (xvel * .001)

	aoa = math.tan(ypos/xpos)
	aoa = (aoa / math.pi) * 180
	if (yvel == 0):
		print(f'{time:10}:v: {xvel:10},{yvel:10} aoa: {aoa:2} vector: {xposwas:10},{yposwas:10} ==> {xpos:10}, {ypos:10} ')

	if ((xpos % 100) == 0):
		velocity = math.sqrt((xvel ** 2) + (yvel ** 2))
		print(f'{velocity:2} {time:3} {ypos:2}')
		

	if ((time % 20) == 0):
		print(f'{time:10}:v: {xvel:10},{yvel:10} aoa: {aoa:2} vector: {xposwas:10},{yposwas:10} ==> {xpos:10}, {ypos:10} ')
		screen.create_line((xposwas*hscale)+20, (460-(yposwas*vscale)), (xpos*hscale)+20, (460-(ypos*vscale)), width=2, fill="red")
		canvas.pack()
		xposwas = xpos
		yposwas = ypos

	if (ypos < 0): break
 
root.mainloop()
