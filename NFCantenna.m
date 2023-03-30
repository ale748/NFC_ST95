clear all;
close all;
clc;
f = 13.56e6;
w = 2*pi*f;
s = 1i*w;



Params.Rout=27;
Params.RST = 1e10;
Params.CST = 2.2e-11;

Params.Rin=50;

Params.L01 = 560e-9;
Params.L02 = 560e-9;
Params.C01 = 200e-12;
Params.C02 = 200e-12;

Params.Rrx = 330;
Params.Crx = 1e12;


Params.Ra = 0.8;
Params.La = 1.25e-6;
Params.Vps = 3;

[xC1,xC2]=NFC_Match(f,Params);
xC1
xC2

Params.C1 = xC1;
Params.C2 = xC2;
[Mag, Phase] = NFC_Ant(f,Params)

##Params.C1 = 47e-12;
##Params.C2 = 82e-12;
C1_user = Params.C1
C2_user = Params.C2

[Mag, Phase] = NFC_Ant(f,Params)

ftest = 10e6:0.1e6:17e6;
Mag = zeros(size(ftest));
Phase = zeros(size(ftest));

for i=1:length(ftest)
  [M,P] = NFC_Ant(ftest(i),Params);
  Mag(i) = M;
  Phase(i) = P;
end
maxceil = ceil(max(Mag)/10)*10;
fline = [0 maxceil];
ax = plotyy(ftest/1e6,Mag,ftest/1e6,Phase);
grid on
hold on
plot([f f]/1e6,fline,'k--')
##plot(ftest/1e6,Mag,'b',[f f]/1e6,fline,'k--');
##axis([min(ftest)/1e6 max(ftest)/1e6 0 maxceil]);
##
##
##plot(ftest,Phase,'r')
##phaseceil = [ceil(min(Phase)/10)*10 ceil(max(Phase)/10)*10];
##axis([min(ftest)/1e6 max(ftest)/1e6 phaseceil(1) phaseceil(2)]);

figure
fvolt = 5e6:0.1e6:20e6;
Vin = zeros(size(fvolt));
VEmi = zeros(size(fvolt));
Vrx = zeros(size(fvolt));
Vant = zeros(size(fvolt));



for i=1:length(fvolt)
  [Vi, Ve, Vr, Va] = NFC_Volt(fvolt(i),Params);
  Vin(i)=Vi;
  VEmi(i)=Ve;
  Vrx(i)=Vr;
  Vant(i)=Va;

end


maxV = max([Vin VEmi Vant Vrx]);
maxVceil = ceil(maxV/5)*5;
fline = [0 maxVceil];
plot(fvolt/1e6,Vin,'b',fvolt/1e6,VEmi,'r',fvolt/1e6,Vant,'g',fvolt/1e6,Vrx,'b--',[f f]/1e6,fline,'k--');
axis([min(fvolt)/1e6 max(fvolt)/1e6 0 maxVceil]);

grid on;

##
##Zrx = 2*Rrx + (1/(s*Crx/2))
##ZCst = 1/(s*CST);
##Za = Ra+s*La;
##
##L0 = L01+L02;
##ZL0 = s*L0;
##C0 = 1/((1/C01)+(1/C02));
##ZC0 = 1/(s*C0);
##ZoutEmi =  1/((1/(Rout+ZL0)) + (1/(ZC0)))
##ZrxST = 1/((1/RST)+(1/(ZCst)))
##
##
##ZrxTot = Zrx + ZrxST
##ZrxAnt = 1/((1/Za)+(1/ZrxTot));
##
##Z1 = Za*ZrxTot/(Za+ZrxTot)
##Rz1 = real(Z1);
##Iz1 = imag(Z1);
##Rzo = real(ZoutEmi);
##Izo = -imag(ZoutEmi);
##XC2(1) = (sqrt(Rz1*Rzo*(Iz1^2+Rz1^2-Rz1*Rzo))+Iz1*Rzo)/(Rz1-Rzo);
####XC2(2) = (sqrt(Rz1*Rzo*(Iz1^2+Rz1^2-Rz1*Rzo))-Iz1*Rzo)/(Rz1-Rzo);
##YC1 = Izo/2-(((Iz1^2.*XC2)+(Iz1.*XC2.^2)+(Rz1^2.*XC2))./(2*((Iz1^2)+(2*Iz1*XC2)+(Rz1^2)+(XC2.^2))));
##C2 = -1./(XC2*w)
##C1 = -1./(YC1*w)
##ZC1 = 1/(s*C1);
##ZC2 = 1/(s*C2);
##
##ZinTune = 2*ZC1 + (ZC2*Z1)/(ZC2+Z1)
##Zin = (ZinTune*ZC0)/(ZinTune+ZC0) + ZL0
##Mag = abs(Zin)
##Phase = arg(Zin)*180/pi
##
##

##
##ZC2 = 1/(s*C2);
##Zin2 = (ZC1/2) + 1/((1/ZC2)+(1/ZrxTot)+(1/Za));
##Mag = abs(Zin2+ZoutEmi)
##Phase = arg(Zin2+ZoutEmi)*180/pi
##Ztune = 2*ZC1 + (ZC2*Z1/(ZC2*Z1))
