from tkinter import *
root = Tk()
canvas = Canvas(root)
 
root.geometry("600x200")

canvas.create_line(0, 10, 20, 10, width=1)
canvas.pack()

root.mainloop()
