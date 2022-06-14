sets
         i tipo de medicamento /Polos,Camisas,PantalonesVestir,Jeans,Ponchos,Chaquetas/
parameters
         C(i) COSTO DE COMPRA DE LA PRENDA I
         /
         Polos  8
         Camisas  10
         PantalonesVestir  18
         Jeans  15
         Ponchos  12
         Chaquetas  19
         /
         P(i) PRECIO DE VENTA DE LA PRENDA I
         /
         Polos  13
         Camisas  14
         PantalonesVestir  24
         Jeans  19
         Ponchos  17
         Chaquetas  23
         /
         CM(i) CANTIDAD MAXIMA DE LA PRENDA I
         /
         Polos   60
         Camisas         20
         PantalonesVestir         16
         Jeans           20
         Ponchos         20
         Chaquetas       12
         /
         CF(i) COSTO DE FOLLETOS PARA LA PRENDA I
         /
         Polos   4
         Camisas         4
         PantalonesVestir        5
         Jeans           5
         Ponchos         6
         Chaquetas       6
         /
;
variables
         Gan funcion objetivo ganancia
         x(i) cantidad de prenda i a comprar
         y(i) varible de decision binaria para comprar una prenda
;
integer variables x;
binary variables y;

equations
FO funcion objetivo
R1 Chaquetas o ponchos pero no los dos a la vez
R2  Ya sea chaquetas o ponchos como minimo 6 unidades
R3  Ya sea chaquetas o ponchos como minimo 6 unidades
R4 Debe comprar como minimo tres tipos de prendas
R5 Dispone de 1000 para realizar comprar y elaborar folletos
R6(i) Cantidad maxima de unidades
R7(i) Relacion de variables binarias con variables enteras

;
FO..     Gan=E=sum(i,P(i)*x(i)-C(i)*x(i)-CF(i)*y(i));
R1..     y('Ponchos')+y('Chaquetas')=E=1;
R2..     x('Ponchos')=G=6*y('Ponchos');
R3..     x('Chaquetas')=G=6*y('Chaquetas');
R4..     sum(i,y(i))=G=3;
R5..     sum(i,C(i)*x(i)+CF(i)*y(i))=L=1000;
R6(i)..  x(i)=L=CM(i);
R7(i)..  x(i)=L=CM(i)*y(i);
model testpunto1 /all/;
solve testpunto1 using MIP maximizing Gan ;
display x.l,y.l;