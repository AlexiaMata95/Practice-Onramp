#include<iostream>
#include<math.h>
#include<stdlib.h>

using namespace std;

int main (){
	int i,a;
	float xi,xf,h,k,y,k1,k2,k3,k4;
	
	cout<<"Ingrese valor inicial de x Hello : \nx0 = ";
	cin>>xi;
	cout<<"Ingrese valor final de x : \nxf =";
	cin>>xf;
	cout<<"Ingrese valor inicial de y : \ny =";
	cin>>y;
	cout<<"Ingrese numero de iteraciones : \ni =";
	cin>>i;
	h = (xf - xi)/i;
	cout<<"\nh = "<<h<<endl;
	cout<<"0  |x= "<<xi<<"  y= "<<y;
	
	
	k1 = (y+1)*(xi+1)*cos((pow(xi,2)+(2*xi)));
	k2 = ((y+((h/2)*k1))+1)*( (xi+(h/2))+1)*cos((pow((xi+(h/2)),2)+(2*(xi+(h/2)))));
	k3 = ((y+((h/2)*k2))+1)*((xi+(h/2)) +1)*cos((pow((xi+(h/2)),2)+(2*(xi+(h/2)))));
	k4 = ((y+(h*k3)+1)*( (xi+h)+1)*cos((pow((xi+h),2)+(2* (xi+h)))));
	
	cout<<"  k1= "<<k1<<"  k2= "<<k2<<"  k3= "<<k3<<"  k4= "<<k4<<endl;
	k = xi+h;
	for(a = 1; a<=i ; a++)
	{
		y = y + ((h/6)*(k1+(2*k2)+(2*k3)+k4));
		k1 = (y+1)*(k+1)*cos((pow(k,2)+(2*k)));
		k2 = ((y+((h/2)*k1))+1)*((k+(h/2))+1)*cos((pow((k+(h/2)),2)+(2*(k+(h/2)))));
		k3 = ((y+((h/2)*k2))+1)*((k+(h/2))+1)*cos((pow((k+(h/2)),2)+(2*(k+(h/2)))));
		k4 = ((y+(h*k3))+1)*((k+h)+1)*cos((pow((k+h),2)+(2*(k+h))));
		
		cout<<a<<"  |x= "<<k<<"  y= "<<y<<"  k1= "<<k1<<"  k2= "<<k2<<"  k3= "<<k3<<"  k4= "<<k4<<endl;
		k=k+h;
	}
	cout<<"\nEl resultado es : \n\ty = "<<y<<endl;
	
	system ("pause");
}

