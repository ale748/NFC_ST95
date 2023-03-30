function [Vin, VEmi, Vrx, Vant] = NFC_Volt(f,Params);


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
Vps = Params.Vps;


ZCst = 1/(s*CST);
Zrx = 2*Rrx + (1/(s*Crx/2));


Za = Ra+s*La;


L0 = L01+L02;
ZL0 = s*L0;
C0 = 1/((1/C01)+(1/C02));
ZC0 = 1/(s*C0);
ZoutEmi =  1/((1/(Rin+ZL0)) + (1/(ZC0)));
ZrxST = 1/((1/RST)+(1/(ZCst)));
ZC1 = 1/(s*C1);
ZC2 = 1/(s*C2);


ZrxTot = Zrx + ZrxST;
ZrxAnt = 1/((1/Za)+(1/ZrxTot));

Z1 = Za*ZrxTot/(Za+ZrxTot);
Z1C2 = Z1*ZC2/(Z1+ZC2);
Z1C1C2 = Z1C2+2*ZC1;


ZC0eq = ZC0*Z1C1C2/(ZC0+Z1C1C2);
io = Vps/(Rout+ZL0 + ZC0eq);
Vin = io*(ZL0+ZC0eq);
VEmi = io*ZC0eq;
i1 = VEmi/(Z1C1C2);
Vant = i1*Z1C2;
i3 = Vant/(ZrxTot);
Vrx = i3*ZrxST;
Vin = abs(Vin);
VEmi = abs(VEmi);
Vrx = abs(Vrx);
Vant = abs(Vant);

