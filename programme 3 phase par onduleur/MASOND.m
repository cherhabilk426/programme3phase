%%%%%%%%%%%%%%%%%%%paramètres de la machine:
clc;clear;
rs=4.85;rr=3.805;ls=0.274;lr=0.274;lm=0.258;
j=0.031;p=2;f=0.008;
tr=lr/rr;
ts=ls/rs;
s=1-lm*lm/(lr*ls);
ws=100*pi;
Ieff=5;
int1=0;int2=0;int3=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=0.0001;
tf=4;
x=[0;0;0;0;0;0]; 
k=1; t=k*h;

while t<=tf;
   
   if (t>2 & t<4) cr=10; else cr=0; end;
   %cr=0;
iasref=sqrt(2)*Ieff*sin(ws*t);
ibsref=sqrt(2)*Ieff*sin(ws*t-2*pi/3);
icsref=sqrt(2)*Ieff*sin(ws*t+2*pi/3)

thetas=x(6);

ias=sqrt(2/3)*(x(3)*cos(thetas)-x(4)*sin(thetas));
ibs=sqrt(2/3)*(x(3)*cos(thetas-2*pi/3)-x(4)*sin(thetas-2*pi/3));
ics=sqrt(2/3)*(x(3)*cos(thetas+2*pi/3)-x(4)*sin(thetas+2*pi/3));

tensionref=ondhyst(ias,ibs,ics,iasref,ibsref,icsref,int1,int2,int3);

vas=tensionref(1);
vbs=tensionref(2);
vcs=tensionref(3);

vds1=sqrt(2/3)*(vas*cos(thetas)+vbs*cos(thetas-2*pi/3));
vds=vds1+sqrt(2/3)*vcs*cos(thetas+2*pi/3);
vqs1=-sqrt(2/3)*(vas*sin(thetas)+vbs*sin(thetas-2*pi/3));
vqs=vqs1-sqrt(2/3)*vcs*sin(thetas+2*pi/3);

x1=x; k1=derives(x1,vds,vqs,ws,cr);
x2=x1+0.5*h*k1; k2=derives(x2,vds,vqs,ws,cr);
x3=x1+0.5*h*k2; k3=derives(x3,vds,vqs,ws,cr); 
x4=x1+h*k3; k4=derives(x4,vds,vqs,ws,cr);

x=x1+h*(k1+2*k2+2*k3+k4)/6;

phds(k)=x(1);
phqs(k)=x(2);
ids(k)=x(3);
iqs(k)=x(4);
wm(k)=x(5);
thetas=x(6);

cem(k)=p*(iqs(k)*phds(k)-ids(k)*phqs(k));
phdr(k)=lr*phds(k)/lm-s*ls*lr*ids(k)/lm;
phqr(k)=lr*phqs(k)/lm-s*ls*lr*iqs(k)/lm;
phr(k)=sqrt(phdr(k)*phdr(k)+phqr(k)*phqr(k));
iass(k)=sqrt(2/3)*(ids(k)*cos(thetas)+iqs(k)*sin(thetas));
n(k)=25*wm(k)/(p*pi);

vass(k)=vas;
vbss(k)=vbs;
vcss(k)=vcs;
crr(k)=cr;

tk(k)=t;home, t
k=k+1; t=t+h;
end;
figure(1)
subplot(3,2,1),plot(tk,n),grid,ylabel('n(tr/min)'); 
axis([0 tf 0 1300])
subplot(3,2,2),plot(tk,phdr),grid, ylabel('phdr(wb)'); 
subplot(3,2,3),plot(tk,cem),grid, ylabel('cem(Nm)'); 
subplot(3,2,4),plot(tk,phqr),grid, ylabel('phqr(wb)'); 
subplot(3,2,5),plot(tk,iass),grid,xlabel('t(s)'); ylabel('ias(A)'); 
subplot(3,2,6),plot(tk,iqs),grid,xlabel('t(s)'); ylabel('iqs(A)');
