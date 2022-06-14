sets
         i tipo de vacuna /AnticovidTipo1,AnticovidTipo2/
         j componentes /COVID19,conservantes,coadyuvantes,proteinahuevo/
         k plantas /Bogota,Cali/
         l centros de distribucion /Barranquilla,Medellin,Tunja,Popayan/
         m mes /Septiembre,Octubre,Noviembre,Diciembre/
;
parameters
         td(i) tamaño de la dosis (ml) para la vacuna tipo i
         /
         AnticovidTipo1  5
         AnticovidTipo2  8
         /
         CM(j) costo materia prima por ml para componente tipo j
         /
         COVID19         0
         conservantes    350
         coadyuvantes    800
         proteinahuevo   550
         /
         DIS(j) disponibilidad de materia prima en ml para componente tipo j
         /
         COVID19         +INF
         conservantes    1E7
         coadyuvantes    8E6
         proteinahuevo   12E6
         /
         cp(i) costo produccion de una dosis para la vacuna tipo i
         /
         AnticovidTipo1  2300
         AnticovidTipo2  2600
         /
         ca(i) costo de almacenamiento por dosis para la vacuna tipo i
         /
         AnticovidTipo1  750
         AnticovidTipo2  1000
         /
         fd(m) factor de atencion de demanda
         /
         Septiembre      0.35
         Octubre         0.25
         Noviembre       0.2
         Diciembre       0.2
         /
         table NPD(i,l) demanda en los centros de distribucion l de la vacuna tipo i
                         Barranquilla    Medellin        Tunja           Popayan
         AnticovidTipo1  120000          145000          80000           35000
         AnticovidTipo2  6500            12300           2600            800
         table ct(k,l) costos de transporte por mililitro desde la planta k hasta el centro de distribucion l
                         Barranquilla    Medellin        Tunja           Popayan
         Bogota          0.0045          0.00015         0.0008          0.015
         Cali            0.065           0.0035          0.0038          0.00034
         table invD(i,k) inventario para diciembre de la vacuna i en la planta k
                         Bogota          Cali
         AnticovidTipo1  5000            3200
         AnticovidTipo2  2300            1300
;
variables
         CostoT funcion objetivo costo total
         x(i,k,m) cantidad de unidades a producir de vacuna
         y(i,k,l,m) cantidad de vacunas a transportar
         z(i,j,k,m) cantidad de componentes
         w(i,k,m) cantidad de vacunas almacenadas a final de mes
;
positive variables x;
positive variables w;
positive variables y;
positive variables z;
equations
FO funcion objetivo
Rcu(i,k,m) relacion de componentes y unidades
R1covid(k,m) restriccion de COVID vacuna 1
R1cons(k,m) restriccion de conservantes vacuna 1
R1coad(k,m)  restriccion de coadyuvantes vacuna 1
R2covid(k,m)  restriccion de COVID vacuna 2
R2cons(k,m)   restriccion de conservantes vacuna 2
R2coad(k,m)   restriccio de coadyuvates vacuna 2
RInv(i,k)     restriccion de inventario para diciembre
RptS(i,k)  balance de lo que se produce se almacena y se transporta septiembre
RptO(i,k)  balance de lo que se produce se almacena y se transporta octubre
RptN(i,k)  balance de lo que se produce se almacena y se transporta noviembre
RptD(i,k)  balance de lo que se produce se almacena y se transporta diciembre
RD(i,l,m) restriccion de demanda de solicitudes que se debe cumplir
RMP(j)  disponibilidad por componente de materia prima
;
FO..     CostoT=E=sum((i,k,m),cp(i)*x(i,k,m))+sum((i,j,k,m),CM(j)*z(i,j,k,m))+sum((i,k,l,m),ct(k,l)*y(i,k,l,m))+sum((i,k,m),ca(i)*w(i,k,m));
Rcu(i,k,m)..    sum((j),z(i,j,k,m))=E=td(i)*x(i,k,m);
R1covid(k,m)..      z("AnticovidTipo1","COVID19",k,m)=L=0.35*sum((j),z("AnticovidTipo1",j,k,m));
R1cons(k,m)..      z("AnticovidTipo1","conservantes",k,m)=L=0.15*sum((j),z("AnticovidTipo1",j,k,m));
R1coad(k,m)..      z("AnticovidTipo1","coadyuvantes",k,m)=L=0.1*sum((j),z("AnticovidTipo1",j,k,m));
R2covid(k,m)..      z("AnticovidTipo2","COVID19",k,m)=L=0.4*sum((j),z("AnticovidTipo2",j,k,m));
R2cons(k,m)..      z("AnticovidTipo2","conservantes",k,m)=E=0.15*sum((j),z("AnticovidTipo2",j,k,m));
R2coad(k,m)..      z("AnticovidTipo2","coadyuvantes",k,m)=E=0.1*sum((j),z("AnticovidTipo2",j,k,m));
RInv(i,k)..        w(i,k,"Diciembre")=E=invD(i,k);
RptS(i,k)..       x(i,k,"Septiembre")-sum((l),y(i,k,l,"Septiembre"))=E=w(i,k,"Septiembre");
RptO(i,k)..       x(i,k,"Octubre")+w(i,k,"Septiembre")-sum((l),y(i,k,l,"Octubre"))=E=w(i,k,"Octubre");
RptN(i,k)..       x(i,k,"Noviembre")+w(i,k,"Octubre")-sum((l),y(i,k,l,"Noviembre"))=E=w(i,k,"Noviembre");
RptD(i,k)..       x(i,k,"Diciembre")+w(i,k,"Noviembre")-sum((l),y(i,k,l,"Diciembre"))=E=w(i,k,"Diciembre");
RD(i,l,m)..        sum((k),y(i,k,l,m))=G=fd(m)*NPD(i,l);
RMP(j)..           sum((i,k,m),z(i,j,k,m))=L=DIS(j);
model SolPar/all/;
solve SolPar using MIP minimizing CostoT ;
display x.l,y.l,w.l,z.l;


