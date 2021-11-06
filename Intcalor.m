%% Intercambiador de doble tubo
% Alexia Irais Mata Pérez 13/11/2019
% Base de datos.
clc
close
clear

%% Datos geometricos generales.

%% Propiedades del tubo (Acero inoxidable 316L 100 °C)
% Conductividad térmica (W/mK)
Kw=16.3; %W/mK
%% Propiedades geometricas del evaporador.
% Diametro interno del tubo interno (m).
d1=0.00622;
r1=d1/2;
% Diametro externo del tubo interno (m).
d2=0.00952;
r2=d2/2;
% Diametro interno del tubo externo (m).
d3=0.01575;
r3=d3/2;
% Diametro externo del tubo externo (m).
d4=0.01905;
r4=d4/2;
% Longitud (m).
L=3.6;

% Area de transferencia del tubo interno(m^2).
Ai=pi*d1*L;
% Diametro hidraulico(m).
Dh=((d3^2)-(d2^2))/d2;
% Area de transferencia del tubo externo (m^2).
Ao=pi*Dh*L;
% Area de sección transversal del tubo externo (m^2).
Aa=pi*((Dh/2)^2);

%Presión del tubo externo.
Po=0.816;

%% SET DE PRUEBAS EXPERIMENTALES.
%[W(kg/s) Pin [bar] Tent[°C] Tsal[°C] // EXTERNO W(kg/s) Pin [bar] Tent[°C]
%Tsal[°C]]

BD=xlsread('basededatosint.xlsx','A4:H63');
[l,c]=size(BD);

% Flujo másico del tubo interno (kg/s)
MI=BD(:,1);
% Presión del tubo interno (bar)
PT=BD(:,2);
% Temperatura de entrada del tubo interno (°C)
TTi=BD(:,3);
% Temperatura de salida del tubo interno;
TTo=BD(:,4);

% Flujo masico del anulo(kg/s)
MA=BD(:,5);
% Presión del anulo(bar)
PA=BD(:,6);
% Temperatura de entrada del anulo (°C)
TAi=BD(:,7);
% Temperatura de salida del anulo (°C);
TAo=BD(:,8);


%% Parametros importantes.

for i=1:l
    % Potencia externa en base al anulo (kJ/s)
    % Entalpía de entrada del anulo (kJ/kg)
    hAi(i)=XSteam('h_pT',PA(i),TAi(i));
    % Entalpía de salida del anulo (kJ/kg)
    hAo(i)=XSteam('h_pT',PA(i),TAo(i));
    %Potencia en KJ/s y W.
    Qo(i)=MA(i)*(hAi(i)-hAo(i));
    QoW(i)=Qo(i)*1000;
    


%% Media logaritmica de temperatura

dT1(i)=TAo(i)-TTi(i);
dT2(i)=TAi(i)-TTo(i);

MLDT(i)=(dT1(i)-dT2(i))/(log(dT1(i)/dT2(i)));



%% Calculo de Area externa.
UA(i)=(Qo(i)/MLDT(i))*1000; %Coeficiente global de transferencia por area
U(i)=((Qo(i)/MLDT(i))/Ao)*1000; %Coeficiente global de transferencia.

%% Calculo de resistencias.
Rw(i)=(log(r2/r1))/(2*pi*L*Kw); %Resistencia termica de la pared.

%Temperatura promedio externa (°C).
TPe(i)=(TAi(i)+TAo(i))/2;
kl(i)=XSteam('tc_pT',Po,TPe(i));
Cp(i)=XSteam('Cp_pT',Po,TPe(i))*1000;

% Numero de Nusselt para agua.
Dens(i)=XSteam('Rho_pT',Po,TPe(i)); %kg/m3
Visc(i)=XSteam('my_pT',Po,TPe(i)); %Pa.s
Pr(i)=(Cp(i)*Visc(i))/kl(i);

V2(i)=MA(i)/(Aa*Dens(i));
Re(i)=(Dens(i)*V2(i)*Dh)/Visc(i);

Nu(i)=(Pr(i)^0.3)*(Re(i)^0.8);

he(i)=Nu(i)*kl(i)/Dh;
R2(i)=1/(he(i)*Ao);

Rg(i)=1/UA(i);
h1(i)=1/((Rg(i)-Rw(i)-R2(i))*Ai);

%% Tubo interno
% Temperatura promedio del tubo interno
Tpi(i)=(TTi(i)+TTo(i))/2;
% Temperatura de Saturación.
Tsat(i)=XSteam('Tsat_p',PT(i));
% Conductividad térmica.
klsat(i)=XSteam('tcL_T',Tsat(i));
% Número de Nusselt
Nusat(i)=(d1*h1(i))/klsat(i);
% Densidad 
Rho(i)=XSteam('rhoL_T',Tsat(i));
Ai=0.0703;
% Viscosidad
Viscs(i)=XSteam('my_pT',PT(i),Tpi(i));
% Velocidad en el tubo interno
V(i)=MI(i)/(Rho(i)*Ai);
%Número de Reynolds
Rei(i)=Rho(i)*V(i)*d1/Viscs(i);
% Calor específico del tubo interno
Csi(i)=(XSteam('CpL_T',Tsat(i)))*1000;
% Numero de Prandlt
Prsa(i)=Csi(i)*Viscs(i)/klsat(i);


R=[hAi' hAo' Qo' QoW' MLDT' UA' U' Rw' TPe' kl' he' h1' Rg' R2' Tpi' Tsat' klsat' Nusat' Rho' Viscs' V' Rei' Csi' Prsa'];

end 

xlswrite('basededatosint.xlsx',R,1,sprintf('I%d',4));

disp('La ecuación que daría una aproximación del número de Nusselt a partir de Reynolds y Prandlt es:');
disp('Nu=89.81*(Re^0.9068)*(Pr^-0.1985)')
disp('Con un error medio aproximado de: 0.02582')
