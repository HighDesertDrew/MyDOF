CC = gcc
CFLAGS = -lm #tell the compiler to link <math.h>

all: %.c
	$(CC) $^ -o $@ -lm 

clean:
	echo "This place is a mess, time to clean up"
	echo "removing editor backups *~"
	rm -f *~
	echo "Object files? Nope!"
	rm -f *.o
	echo "compiled binaries? Gone!!"
	rm -f solvinterval
	
