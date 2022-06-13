Sets
r   referencias /ref1,ref2,ref3,ref4/
c   comercio /comercio1,comercio2,comercio3/
f   fabricas /fabrica1,fabrica2,fabrica3/
m   empresas logisticas /emplog1,emplog2,emplog3/
;
Scalar
Plim porcentaje limite por referencia a transportar /0.75/;
Table
DEM(r,c) demandas de las tiendas de acuerdo a referencia
        comercio1   comercio2   comercio3
ref1    15          9           36
ref2    22          16          21
ref3    17          9           45
ref4    8           2           30;
Table
INV(r,c) inventarios de las tiendas de acuerdo a referencia
        comercio1   comercio2   comercio3
ref1    3           3           3
ref2    5           1           4
ref3    2           4           4
ref4    6           2           3;
Table
DIS(r,f) disponibilidades en las fabricas de acuerdo a referencia
        fabrica1    fabrica2    fabrica3
ref1    48          60          36  
ref2    80          74          50
ref3    66          88          60
ref4    30          62          74;
Table
U(m,f) parametro binario de cobertura
            fabrica1    fabrica2    fabrica3
emplog1     1           1           0
emplog2     1           0           1
emplog3     0           1           1;
Table
CT(f,c,m) costo variable por unidad transportada desde la planta del fabricante al comercio
                    emplog1     emplog2     emplog3
fabrica1.comercio1    110         50          60
fabrica1.comercio2    120         110         50
fabrica1.comercio3    70          60          70
fabrica2.comercio1    40          120         100
fabrica2.comercio2    40          120         80
fabrica2.comercio3    100         120         60
fabrica3.comercio1    60          100         60
fabrica3.comercio2    120         40          70
fabrica3.comercio3    40          70          50;
integer variables
x(r,f,c,m) cantidades de una referencia r transportada desde la fabrica f hasta el centro c mediante la empresa m
;
free variables z;

Equations
FO ecuacion de la funcion objetivo minimizar los costos
Oferta(r,f)    oferta en las fabricas
Demanda(r,c)   demanda en las tiendas
Diver1(r)     restriccion comercial y de diversificacion del riesgo
Diver2(r)     restriccion comercial y de diversificacion del riesgo
Diver3(r)     restriccion comercial y de diversificacion del riesgo
Comercio3(r,f)      restriccion relacionada con el comercio 3
;
FO..                z=E=sum((r,f,c,m),CT(f,c,m)*U(m,f)*x(r,f,c,m));
Oferta(r,f)..       sum((c,m),U(m,f)*x(r,f,c,m))=L=DIS(r,f);
Demanda(r,c)..      sum((f,m),U(m,f)*x(r,f,c,m))=G=DEM(r,c)-INV(r,c);
Diver1(r)..        sum((f,c),U('emplog1',f)*x(r,f,c,'emplog1'))=L=Plim*sum((f,c,m),U(m,f)*x(r,f,c,m));
Diver2(r)..        sum((f,c),U('emplog2',f)*x(r,f,c,'emplog2'))=L=Plim*sum((f,c,m),U(m,f)*x(r,f,c,m));
Diver3(r)..        sum((f,c),U('emplog3',f)*x(r,f,c,'emplog3'))=L=Plim*sum((f,c,m),U(m,f)*x(r,f,c,m));
Comercio3(r,f)..    U('emplog2',f)*x(r,f,'comercio3','emplog2')=E=0;

Model todopromo /ALL/;
option MIP = CPLEX;
solve todopromo using MIP minimizing z;
display x.l,z.l;

