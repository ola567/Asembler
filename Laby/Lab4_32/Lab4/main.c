#include <stdio.h>
#define _CRT_SECURE_NO_WARNINGS

long long ram();
int fib(int k);

int main()
{	
	long i = ram()/1000;
	printf("%ld", i);

	//int k = 3;
	//int wynik;
	//wynik = fib(k);
	//printf("%d", wynik);


	/*int a, b = 2;
	a = funkcja(b);
	printf("%d", a);*/

	////odejmowanie dwóch liczb ca³kowitych
	//int a, b, * wsk, wynik;
	//wsk = &a;
	//a = 21;
	//b = 25;
	//wynik = odejmowanie(&wsk, &b);
	//printf("%d", wynik);

	////Element maksymalny tablicy
	//int pomiary[] = {3,6,12,7,34,65,3};
	//int * wsk;

	//wsk = szukaj_elem_max(pomiary, 7);
	//printf("\nElement maksymalny = %d\n ", *wsk);

	////Sprawdzanie, czy jest œcie¿k¹ systemow¹
	//char* directory = {"C:\\Windows\\system32"};
	//unsigned int wynik=check_system_dir(directory);
	//if (wynik == 0)
	//{
	//	printf("Parametr wejsciowy nie jest sciezka systemowa");
	//}
	//else
	//	printf("Parametr wejsciowy jest sciezka systemowa");

	////Dzielenie
	//int* dzielna = -8;
	//int dzielnik = -2;
	//int* wsk;
	//wsk = &dzielnik;
	//int wynik = dzielenie(&dzielna, &wsk);
	//printf("%d", wynik);

	////scalanie dwóch tablic
	//int n=3;
	//int tab1[3];
	//int tab2[3];

	//for (int i = 0; i < n; i++)
	//{
	//	scanf_s("%d", &tab1[i]);
	//}
	//for (int i = 0; i < n; i++)
	//{
	//	scanf_s("%d", &tab2[i]);
	//}
	//
	//int *wynik = malloc(2*n*sizeof(int)); 
	//wynik=merge(tab1, tab2, n);
	//if (wynik == NULL)
	//{
	//	printf("Zbyt duze tablice!!\n");
	//}
	//else 
	//{
	//	for (int i = 0; i < 2 * n; i++)
	//	{
	//		printf("%d ", wynik[i]);
	//	}
	//}

	//iloczym wektorowy
	//int n;
	//scanf_s("%d", &n);
	//int *tab1=malloc(n*sizeof(int));
	//int *tab2=malloc(n*sizeof(int));

	//printf("Wczytujemy do pierwszej tablicy:");
	//for (int i = 0; i < n; i++)
	//{
	//	scanf_s("%d", &tab1[i]);
	//}

	//printf("Wczytujemy do drugiej tablicy:");
	//for (int i = 0; i < n; i++)
	//{
	//	scanf_s("%d", &tab2[i]);
	//}

	//int wynik=dot_produc(tab1, tab2, n);
	//printf("Wynik %d", wynik);
	//free(tab1);
	//free(tab2);

	////funkcja przestaw
	//int tablica[] = { 1,4,3,2,4,9,-2 };
	//int rozmiar = 7;
	//przestaw(tablica, rozmiar);

	//printf("\nPosortowana tablica: ");
	//for (int i = 0; i < rozmiar; i++)
	//{
	//	printf("%d ", tablica[i]);
	//}

	////funkcja udejmij_jeden
	//int k;
	//int* wsk;
	//wsk = &k;
	//printf("\nProsze napisac liczbe: ");
	//scanf_s("%d", &k, 12);
	//odejmij_jeden(&wsk);
	//printf("\nWynik = %d\n", k);

	//funkcja przeciwna
	//int n = -4;
	//przeciwna(&n);
	//printf("\n n = %d\n", n);

	////funkcja plus_jeden
	//int m = -5;
	//plus_jeden(&m);
	//printf("\n m = %d\n", m);

	////funkcja szukaj_max
	//int x, y, z, w, wynik;
	//printf("\nProsze podac cztery liczby calkowite ze znakiem: ");
	//scanf_s("%d %d %d %d", &x, &y, &z, &w);

	//wynik = szukaj_max(x, y, z, w);
	//printf("\nSposrod podanych liczb %d, %d, %d, %d liczba %d jest najwieksza.\n", x, y, z, w, wynik);
	return 0;
}
