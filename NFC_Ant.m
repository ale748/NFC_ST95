function [Mag, Phase] = NFC_Ant(f,Params);
w = 2*pi*f;
s = 1i*w;



Rout=Params.Rout;
RST = Params.RST;
CST = Params.CST;

Rin = Params.Rin;



L01 = Params.L01;
L02 = Params.L02;
C01 = Params.C01;
C02 = Params.C02;

Rrx = Params.Rrx;
Crx = Params.Crx;

Ra = Params.Ra;
La = Params.La;

C1 = Params.C1;
C2 = Params.C2;

ZCst = 1/(s*CST);
Zrx = 2*Rrx + (1/(s*Crx/2));


Za = Ra+s*La;

L0 = L01+L02;
ZL0 = s*L0;
C0 = 1/((1/C01)+(1/C02));
ZC0 = 1/(s*C0);
ZoutEmi =  1/((1/(Rin+ZL0)) + (1/(ZC0)));
ZrxST = 1/((1/RST)+(1/(ZCst)));


ZrxTot = Zrx + ZrxST;
ZrxAnt = 1/((1/Za)+(1/ZrxTot));

Z1 = Za*ZrxTot/(Za+ZrxTot);
Rz1 = real(Z1);
Iz1 = imag(Z1);
Rzo = real(ZoutEmi);
Izo = -imag(ZoutEmi);
##XC2(1) = (sqrt(Rz1*Rzo*(Iz1^2+Rz1^2-Rz1*Rzo))+Iz1*Rzo)/(Rz1-Rzo);
####XC2(2) = (sqrt(Rz1*Rzo*(Iz1^2+Rz1^2-Rz1*Rzo))-Iz1*Rzo)/(Rz1-Rzo);
##YC1 = Izo/2-(((Iz1^2.*XC2)+(Iz1.*XC2.^2)+(Rz1^2.*XC2))./(2*((Iz1^2)+(2*Iz1*XC2)+(Rz1^2)+(XC2.^2))));
##C2 = -1./(XC2*w)
##C1 = -1./(YC1*w)
ZC1 = 1/(s*C1);
ZC2 = 1/(s*C2);

ZinTune = 2*ZC1 + (ZC2*Z1)/(ZC2+Z1);
Zin = (ZinTune*ZC0)/(ZinTune+ZC0) + ZL0;
Mag = abs(Zin);
Phase = arg(Zin)*180/pi;

