#include <stdio.h>
#include <xmmintrin.h>
#define _CRT_SECURE_NO_WARNINGS

float srednia_harm(float *tablica, unsigned int n);
float nowy_exp(float x);
void dodaj_SSE(float*, float*, float*);
void pierwiastek_SSE(float*, float*);
void odwrotnosc_SSE(float*, float*);
void suma(char*,char*, char*);
void int2float(int *calkowite, int *zmiennoprzecinkowe);
void pm_jeden(float* tabl);
void dodawanie_SSE(float* a);
float obj_stozka(unsigned int big_r, unsigned int small_r, float h);
void szybki_max(int t1[], int t2[], int t_wynik[], int n);
void tan();
float find_max_range(float v, float alpha);
__m128 mul_at_once(__m128 one, __m128 two);
float oblicz_potege(unsigned char k, int m);
void dziel(__m128 *tablica1, unsigned int n, float dzielnik);

int main()
{
	//__m128 tablica[3] = { (__m128) {1.0f, 2.0f, 3.0f, 4.0f}, (__m128) { 5.0f, 6.0f, 7.0f, 8.0f }, (__m128) { 9.0f, 10.0f, 11.0f, 12.0f }};
	//dziel(tablica, 3, 2.0);
	//for (int i = 0; i < 3; i++)
	//{
	//	for (int j = 0; j < 4; j++)
	//		printf("%d, %d = %f\n", i, j, tablica[i].m128_f32[j]);
	//}
	
	//float wf;
	//int i;
	//for (i = -7; i < 7; i++)
	//{
	//	wf = oblicz_potege(24, i);
	//	printf("\ni = %d wf = %10.2f", i, wf);
	//}

	//__m128 one;
	//one.m128_i32[0] = 65;
	//one.m128_i32[1] = 120;
	//one.m128_i32[2] = 1200;
	//one.m128_i32[3] = -3;

	//__m128 two;
	//two.m128_i32[0] = 12;
	//two.m128_i32[1] = 32;
	//two.m128_i32[2] = 126;
	//two.m128_i32[3] = -1126;

	//__m128 wynik = mul_at_once(one, two);

	//for (int i = 0; i < 4; i++)
	//{
	//	printf("%d ", wynik.m128_i32[i]);
	//}

	//float v = 12;
	//float alpha = 60;
	//float res = find_max_range(v,alpha);
	//printf("%f ", res);

	//tan();

	//int t1[] = {8,-1,2,2};
	//int t2[] = {-4,12,-2,2};
	//int wynik[4];
	//szybki_max(t1,t2,wynik, 4);
	//for (int i = 0; i < 4; i++)
	//{
	//	printf("%d ", wynik[i]);
	//}

	//unsigned int bigR = 8;
	//unsigned int smallR = 4;
	//float h = 6.1;
	//float wynik = obj_stozka(bigR, smallR, h);
	//printf("%f", wynik);

	/*float wyniki[4];
	dodawanie_SSE(wyniki);
	printf("\nWyniki = %f %f %f %f\n", wyniki[0], wyniki[1], wyniki[2], wyniki[3]);*/

	//float tablica[4] = { 27.5, 143.57, 2100.0, -3.51 };
	//printf("\n%f %f %f %f\n", tablica[0], tablica[1], tablica[2], tablica[3]);
	//pm_jeden(tablica);
	//printf("\n%f %f %f %f\n", tablica[0], tablica[1], tablica[2], tablica[3]);

	//int a[2] = { -17, 24 };
	//float r[4];
	//// podany rozkaz zapisuje w pamiêci od razu 128 bitów,
	//// wiêc musz¹ byæ 4 elementy w tablicy
	//int2float(a, r);
	//printf("\nKonwersja = %f %f\n", r[0], r[1]);

	//char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127 };
	//char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };
	//char tablica_wynikowa[16];

	//suma(liczby_A, liczby_B, tablica_wynikowa);
	//for (int i = 0; i < 16; i++)
	//{
	//	printf("%d ", tablica_wynikowa[i]);
	//}

	/*float p[4] = { 1.0, 1.5, 2.0, 2.5 };
	float q[4] = { 0.25, -0.5, 1.0, -1.75 };
	float r[4];
	dodaj_SSE(p, q, r);
	printf("\n%f %f %f %f", p[0], p[1], p[2], p[3]);
	printf("\n%f %f %f %f", q[0], q[1], q[2], q[3]);
	printf("\n%f %f %f %f", r[0], r[1], r[2], r[3]);
	printf("\n\nObliczanie pierwiastka");
	pierwiastek_SSE(p, r);
	printf("\n%f %f %f %f", p[0], p[1], p[2], p[3]);
	printf("\n%f %f %f %f", r[0], r[1], r[2], r[3]);
	printf("\n\nObliczanie odwrotnoœci - ze wzglêdu na stosowanie");
	printf("\n12-bitowej mantysy obliczenia s¹ ma³o dok³adne");
	odwrotnosc_SSE(p, r);
	printf("\n%f %f %f %f", p[0], p[1], p[2], p[3]);
	printf("\n%f %f %f %f", r[0], r[1], r[2], r[3]);*/

	/*float x = 2.0;
	float res = nowy_exp(x);
	printf("%f\n\n", res);

	float tablica[] = { 1,2,3,4 };
	unsigned int n = 4;
	float wynik = srednia_harm(tablica,n);
	printf("wynik = %f", wynik);*/

	return 0;
}