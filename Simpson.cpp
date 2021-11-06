#include<iostream>
#include<math.h>
#include<stdlib.h>

using namespace std;
//Introducir función
float f(float x) {return x*sin(x);}




int main ()
{
float a,b,h,xi,i,n;
int x=0;
xi=0;
cout<<"Ingrese limite inferior de la integral : "<<endl;
cin>>a;
cout<<"Ingrese limite superior de la integral : "<<endl;
cin>>b;
cout<<"Ingrese numero de intervalos deseados : "<<endl;
cin>>n;

h=(b-a)/n;

for (i=a;i<=b;i=i+h){
	if (i ==a || i == b ){
		xi = xi + (f(i)*(h/3));
	}
	else{
		if (x%2 == 0){
		xi = xi + (f(i)*(2*h/3));
	}
		else {
		xi = xi + (f(i)*(4*h/3));	
		}
	}
	x++;
}

cout<<"El area es = "<<xi<<endl;
system ("pause");
}


