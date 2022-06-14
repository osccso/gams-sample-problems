sets
         i tipo de medicamento /1,2,3,4,5/
         j tipo de maquina /Maquina1,Maquina2,Maquina3,Maquina4,Maquina5,Maquina6,Maquina7,Maquina8/

parameters
         C(j) CAPACIDAD (HORAS-MES) POR MAQUINA j
         /
         Maquina1  40
         Maquina2  32
         Maquina3  33
         Maquina4  26
         Maquina5  27
         Maquina6  38
         Maquina7  20
         Maquina8  38
         /
         Cf(j) COSTOS FIJOS POR MAQUINA j
         /
         Maquina1  440
         Maquina2  390
         Maquina3  71
         Maquina4  248
         Maquina5  464
         Maquina6  429
         Maquina7  229
         Maquina8  511
         /
         t(i) TIEMPO EN MINUTOS POR MEDICAMENTO i
         /
         1       6
         2       2
         3       6
         4       3
         5       4
         /
         D(i) DEMANDA POR MEDICAMENTO UND-MES i
         /
         1       560
         2       130
         3       450
         4       380
         5       270
         /
         table M(j,i) matriz que relacion las maquinas con los medicamentos que pueden producir
                         1       2       3       4       5
         Maquina1        0       1       0       0       1
         Maquina2        1       0       0       1       0
         Maquina3        1       1       1       0       0
         Maquina4        0       1       0       1       1
         Maquina5        1       0       1       1       0
         Maquina6        0       1       0       0       0
         Maquina7        1       0       1       0       1
         Maquina8        0       1       0       0       0
;
variables
         CostoT funcion objetivo costo total
         x(i,j) CANTIDAD A PRODUCIR EN CADA MAQUINA J DEL MEDICAMENTO I
         y(j) variable que determina si la maquina j esta activa (binaria)
;
integer variables x;
binary variables y;

equations
FO funcion objetivo
Cap(j) RESTRICCION DE CAPACIDAD
Costf    Restriccion de costo fijo
Demanda(i) REstriccion de demanda
RVb(i,j) Relacion entre variable positiva y binaria
Cap75(j) restriccion de capacidad del 75%
Maq1 REstriccion maquina 1
;
FO..     CostoT=E=sum(j,Cf(j)*y(j));
Cap(j)..         (1/60)*sum(i,t(i)*x(i,j))=L=C(j);
Costf..          sum(j,Cf(j)*y(j))=L=10000;
Demanda(i)..        sum(j,x(i,j))=G=D(i);
RVb(i,j)..       x(i,j)=L=D(i)*y(j);
Cap75(j)..          (1/60)*sum(i,t(i)*x(i,j))=G=0.75*C(j);
Maq1..           2*y("Maquina1")=L=y("Maquina7")+y("Maquina8");
model SolPar/all/;
solve SolPar using MIP minimizing CostoT ;
display x.l,y.l;
