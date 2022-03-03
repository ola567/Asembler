#include <stdio.h>
#include <mmintrin.h>

typedef __int16 HALF;

unsigned int NWD(unsigned int a, unsigned b);
float obj_stozka_sc(float r, float R, float h);
float MIESZ2float(int m);
float float_razy_float(float a, float b);
HALF float_to_half(float liczba);
float szereg(unsigned int n);
double sortuj(int n, double* tab);
int druk_szeroki(char tab[], int n);
__int64 float2MIESZ(float* q);
short int wyswietl(char * napis);
float podziel(float a);
double ciag(unsigned int *x);
float* XYZ(float *tabXYZ, int n);
char* spacje(char znak);
float funkcja(long long n);
void format();
unsigned int zamien_na_binarny(wchar_t *znaki);
wchar_t* zamien_na_base12(unsigned int liczba);
float szereg2(unsigned int n);
void* rozklad(unsigned __int64 tab[], unsigned int n);
float uint48_float(unsigned __int64 p);

int main()
{
	unsigned __int64 p = 254517;
	float wynik = uint48_float(p);
	printf("%f ", wynik);

	//unsigned __int64 tab[] = {16, 32, 12};
	//unsigned int n = 3;
	//rozklad(tab, n);

	//unsigned int n = 3;
	//float wynik = szereg2(n);
	//printf("%f ", wynik);

	//unsigned int x = 123123;
	//wchar_t* tab = zamien_na_base12(x);
	//printf("%ls\n", tab);

	//wchar_t znaki[6] = {'0', '2' , '1', 0x218A, 0x218B};
	//unsigned int wynik = zamien_na_binarny(znaki);
	//printf("%d ", wynik);

	//format();

	/*long long int n = 4;
	float w = funkcja(n);
	printf("%f", w);*/

	//char znak = 'a';
	//char* wsk = spacje(znak);
	//printf("%s", wsk);

	//float tabXYZ[] = {23, 12, 22, 12, 32, 12, 32, 43, 12};
	//int n = 3;
	//float* wsk=XYZ(tabXYZ, n);
	//for (int i = 0; i < n; i++)
	//{
	//	printf("%f ", wsk[i]);
	//}

	/*unsigned int a = 20;
	unsigned int* x = &a;
	double wynik = ciag(x);
	printf("%lf", wynik);*/

	//float a = 0.4;
	//float w = podziel(a);
	//printf("%f", w);

	//char znaki[] = "Bajt";
	//wyswietl(znaki);

	//float liczba = 0.25;
	//float* q;
	//q = &liczba;
	//float2MIESZ(q);

	//char tab[] = "AKO";
	//int n = 3;
	//druk_szeroki(tab, n);

//Suma n elementów szeregu postaci 1/2+1.3+1/n za pomoc¹ f.rekurencyjnej.
	/*unsigned int n = 8;
	float wynik = szereg(n);
	printf("%f", wynik);*/

//funkcja zamieniaj¹ca z foramtu float na binary16
	/*float liczba = -3.25;
	HALF w = float_to_half(liczba);*/
	
//napisz funkcjê float_razy_float. Nie mo¿na korzystaæ z koprocesora
	/*float a = 12;
	float b = 2;
	float w = float_razy_float(a, b);
	printf("%f", w);*/
		
//Zdefiniowano format miesz32, którego najm³oadszy bit ma wartoœæ 2^(-8).
//Napisz funkcjê, która zmieni liczbê zapisan¹ w tym formacie na liczbê w foramcie float.
	/*int m = 192;
	float wynik = MIESZ2float(m);
	printf("%f", wynik);*/

//Oblicz objêtoœæ sto¿ka œciêtego wyra¿on¹ za pomoc¹ wzoru: V=pi/3*h(R^2+R*r+r^2)
	/*float r = 2;
	float R = 5;
	float h = 23;
	float obj = obj_stozka_sc(r, R, h);
	printf("%f", obj);*/

//Napisaæ program licz¹cy NWD w sposób rekurencyjny wed³ug podanego algorytmu
//unsigend int wyn;
//if (a==b) wyn=a;
//else if (a>b) wyn=NWD(a-b,b);
//else wyn=NWD(a,b-a);
//return wyn;
	/*unsigned int a = 120;
	unsigned int b = 150;
	unsigned int wynik = NWD(a, b);
	printf("%d", wynik);*/

	return 0;
}