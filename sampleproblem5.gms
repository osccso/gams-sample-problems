sets
i        'etapas del proceso' /1*4/
j        'fuentes de produccion' /1*4/
t        'periodos (trimestres)' /1*4/
;
parameter
d(t) 'demanda'
/
1        50500
2        65500
3        82000
4        92000
/



table
c(i,j,t) 'costo unitario'
           1         2         3         4
1.1        25        28        30        28
1.2        28        30        30        32
1.3        30        32        43        32
2.1        45        46        44        48
2.2        48        50        49        50
3.1        12        15        18        19
3.2        14        16        18        20
3.3        13        16        20        22
4.1        24        29        24        28
4.2        24        29        24        27
4.3        26        30        27        25
4.4        28        33        27        25
;
parameters
a(i,j) 'costo preparacion y alistamiento'
/
1.1        25000
1.2        24000
1.3        20000
2.1        24000
2.2        22000
3.1        12000
3.2        10000
3.3        12000
4.1        23000
4.2        25000
4.3        23000
4.4        22000
/
table
Cd (i,j,t) 'capacidad disponible'
           1            2            3            4
1.1        39952        40592        45712        39952
1.2        50510        51310        57710        50510
1.3        112537       114329       128665       112537
2.1        165782       168470       189974       165782
2.2        171670       174486       197014       171670
3.1        39952        40592        45712        39952
3.2        55832        56728        63896        55832
3.3        130812       132924       149820       130812
4.1        28713        29174        32860        28713
4.2        40192        40832        45952        40192
4.3        56571        57467        64635        56571
4.4        72259        73411        82627        72259
;
parameter
h(i) 'costo de mantener el inventario'
/
1        2
2        3
3        4
4        5
/
;
scalar
Cp 'costo penañizacipn' /4/
;
variables
x(i,j,t) 'Variable entera que expresa la cantidad a producir en la etapa de proceso "i" con la fuente "j" en el período "t'
y(i,j,t) 'Variable binaria que expresa la decisión de producir en la etapa de proceso "i" con la fuente "j" en el período "t'
Ib(i,t) 'inventario producto en proceso'
Imas(t) 'inventario disponible de producto terminado'
Imenos(t) 'inventario de producto pendiente'
z 'funcion objtivo'
;
Binary variable
y
;
positive variable
x, Ib, Imas, Imenos;

equations
fo 'funcion objetivo'
Estado11(i,t)
Estado12(i,t)
Estado21(t)
Estado22(t)
capacidad(i,j,t)

CondicionInicial2(i) 'Ii,t'

CondicionInicial4 'Imenos m,t'

CondicionInicial6 'Imas m,t'

;

fo.. z=e=sum((i,j,t),a(i,j)*y(i,j,t))+sum((i,j,t),c(i,j,t)*x(i,j,t))+sum((i,t)$(ord(i)<4),h(i)*Ib(i,t))+sum((t),h('4')*Imas(t))+Cp*sum((t),Imenos(t));
Estado11(i,t)$(ord(i)<4 and ord(t)>1).. sum((j),x(i,j,t))+Ib(i,t-1)-sum((j),x(i+1,j,t))-Ib(i,t)=e=0;
Estado12(i,t)$(ord(i)<4 and ord(t)=1).. sum((j),x(i,j,t))+0-sum((j),x(i+1,j,t))-Ib(i,t)=e=0;
Estado21(t)$(ord(t)>1)..(sum((j),x('4',j,t))+Imas(t-1)-Imas(t)+Imenos(t)-Imenos(t-1))=e=d(t);
Estado22(t)$(ord(t)=1)..(sum((j),x('4',j,t))+1000-Imas(t)+Imenos(t)-0)=e=d(t);
capacidad(i,j,t)..x(i,j,t)=l=Cd(i,j,t)*y(i,j,t);

CondicionInicial2(i)$(ord(i)<4)..Ib(i,'4')=e=0;

CondicionInicial4..Imenos('4')=e=0;

CondicionInicial6..Imas('4')=e=1000;


Model tareaa /all/;
option optcr=0;
solve tareaa using mip minimizing z;
display x.l, y.l, Ib.l, Imenos.l, Imas.l, z.l ;





