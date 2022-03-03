#include <stdio.h>
typedef unsigned int MINUS2;
typedef unsigned int FP24;

float liczba_pi(unsigned int n);
int zamien_minus2_na_u2(MINUS2 p);
void* wystapienia(void* obszar, unsigned int n);
void sortuj(void* tablica, unsigned int);
int* podciag(int* t1, int* t2);
FP24 float_to_fp24(float x);

int main()
{
	float x = -2;
	FP24 w = float_to_fp24(x);

	//int tab1[] = { 1,2,3,4,0 };
	//int tab2[] = { 2,3,0 };
	//int* wsk = podciag(tab1, tab2);

	//char arr[] = "Olaaa";
	//unsigned int n = 5;
	//void* obszar;
	//obszar = &arr;
	//sortuj(obszar, n);

	//MINUS2 a = 0x19;
	//int w = zamien_minus2_na_u2(a);
	//printf("Wynik = %d ", w);

	//unsigned int n = 3;
	//float wynik = liczba_pi(n);
	//printf("%f ", wynik);

	return 0;
}