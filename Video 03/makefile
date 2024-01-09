main: main.o
	ld main.o print.o atoi.o itoa.o random.o -o main
	rm *.o
main.o: main.s
	as -g main.s   -o main.o
	as -g print.s  -o print.o
	as -g atoi.s   -o atoi.o
	as -g itoa.s   -o itoa.o
	as -g random.s -o random.o
clean:
	rm *.o main
