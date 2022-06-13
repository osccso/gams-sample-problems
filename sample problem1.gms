Sets
i productos /mesasinterminar,mesaterminada,sillasinterminar,sillaterminada/
;
Scalar
Ct costo de la madera por pie de tablon /1/
Dt disponibilidad del tablon en pies de tablon /40000/
Dh disponibilidad en horas de mano de obra calificada /6000/
;
Parameters
Mr(i) madera requerida en pies de tablon
/
    mesasinterminar     40     
    mesaterminada       40
    sillasinterminar    30
    sillaterminada      30
/

Mo(i) mano de obra requerida en horas
/
    mesasinterminar     2
    mesaterminada       5
    sillasinterminar    2
    sillaterminada      4
/

Pv(i) precio de venta de acuerdo al producto USD
/
    mesasinterminar     70
    mesaterminada       140
    sillasinterminar    60
    sillaterminada      110
/
;
positive variables
x(i) cantidad a fabricar del producto determinado
free variable z funcion objetivo a maximizar
;
equations
FO funcion objetivo para maximizar la utilidad
Dtablon disponibilidad de tablon
Dhoras disponibilidad de horas de mano de obra calificada
;
FO..        z =E= sum(i,Pv(i)*x(i)-Ct*Mr(i)*x(i));
Dtablon..   sum(i,x(i)*Mr(i)) =L= Dt;
Dhoras..    sum(i,x(i)*Mo(i)) =L= Dh;

Model tallerpunto1 /ALL/;
OPTION LP = CPLEX;
SOLVE tallerpunto1 USING LP maximizing z;
display x.l,z.l


