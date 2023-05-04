COMPILER := gfortran
CFLAGS := -O1

PRG := main
SRC := $(wildcard *.f90 *.f)
OBJ := $(patsubst %.f, %.o, $(patsubst %.f90, %.o, $(SRC)))

build: $(PRG)

$(PRG): $(OBJ)
	$(COMPILER) $(OBJ) -o $@

main.o: modd.o

modd.o: matrix_solver.o

%.o: %.f90
	$(COMPILER) $(CFLAGS) -c -o $@ $<

res: $(PRG)
	./$<
	spd-say 'Ready'

clean:
	rm -f *.o *.mod $(PRG) RESULT
	echo "Cleaned!"
	
plot: RESULT
	python3 plotting.py

.PHONY: clean res build plot
.SILENT: res clean
