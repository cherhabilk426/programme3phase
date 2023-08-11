function Tensionref=Ondhyst(ias,ibs,ics,iasref,ibsref,icsref,f1,f2,f3)

pas=0.1;
 
e1=ias-iasref;
e2=ibs-ibsref;
e3=ics-icsref;

f1_old=f1;

    if e1<-pas
        
      f1=1;
      
   elseif e1>pas
       
      f1=0;
      
   else 
       
      f1=f1_old;
      
   end
   
   f2_old=f2;
   
   if e2<-pas
       
      f2=1;
      
   elseif e2>pas
       
      f2=0;
      
   else 
       
      f2=f2_old;
      
   end
   
   f3_old=f3;
   
   if e3<-pas
       
      f3=1;
      
   elseif e3>pas
       
      f3=0;
      
   else 
       
      f3=f3_old;
      
   end
   
vs=514.6;   
va=vs*(2*f1-f2-f3)/3;
vb=vs*(-f1+2*f2-f3)/3;
vc=vs*(-f1-f2+2*f3)/3;

Tensionref=[va;vb;vc;f1;f2;f3];