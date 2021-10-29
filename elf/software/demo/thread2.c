#include "tti.h"

extern int c;

int main(){

    // STDCLK 1us; TI 0.1s
	int DEFAULT_TG = 0x100000;
	int DEFAULT_TI = 9;

	int time = 9;
    // sim i/o port
	int* ioport = &c;

    // temp variable
    int value;

	settg(2);
	settg(DEFAULT_TG);
	setti(DEFAULT_TI);

	while (1) {

		// inside i-c-o
		// i
		time += 1;
		value = ttiat(ioport, time);
		// c
		value += 1;
		// o
		time += 9;
		ttoat(ioport, value, time);
	}
	return 0;
}
