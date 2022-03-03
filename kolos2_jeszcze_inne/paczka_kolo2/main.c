#include <stdio.h>
#include <math.h>

void compute(float a, float b, float* wynik);

int main()
{
	float a = 1.0 + pow(2.0, -23);
	float b = 10.75f;
	float wynik = 0.0f;
	compute(a, b, &wynik);
	printf("%f", wynik);
	return 0;
}