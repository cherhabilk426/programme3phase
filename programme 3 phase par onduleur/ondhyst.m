function tensionref=ondhyst(ias,ibs,ics,iasref,ibsref,icsref,int1,int2,int3)
pas=0.1;

e1=ias-iasref;
e2=ibs-ibsref;
e3=ics-icsref;

int1old=int1;

if e1>pas,
   int1=0;
elseif e1<-pas,
   int1=1;
else
   int1=int1old;
end;

int2old=int2;

if e2>pas,
   int2=0;
elseif e2<-pas,
   int2=1;
else
   int2=int2old;
end;

int3old=int3;

if e3>pas,
   int3=0;
elseif e3<-pas,
   int3=1;
else
   int3=int3old;
end;

vs=514;   
va=vs*(2*int1-int2-int3)/3;
vb=vs*(-int1+2*int2-int3)/3;
vc=vs*(-int1-int2+2*int3)/3;

tensionref=[va;vb;vc];

