Sets
i aleacion /aleacion1,aleacion2/
j componente /carbono,silicio,niquel/
;
Scalars
Req resistencia requerida a la tension /45000/
;
Parameters
c(i) costo por tonelada
/
aleacion1   190
aleacion2   200
/
Res(i) resistencia de cada aleacion
/
aleacion1   42000
aleacion2   50000
/
Nvb(j) nivel bajo de composicion del componente por cada componente
/
carbono 3.2
silicio 1.8
niquel  0.9
/
Nva(j) nivel alto de composicion del componente por cada componente
/
carbono 3.5
silicio 2.5
niquel  1.2
/

;
Table
Datos(j,i) datos del problema por componente
                aleacion1       aleacion2
carbono         3               4
silicio         2               2.5
niquel          1               1.5;

variable x(i) cantidad de cada aleacion por tonelada
free variable z funcion objetivo
;

Equations

FO      ecuacion de la funcion objetivo
Rnb     restriccion nivel bajo
Rna     resitriccion nivel alto
Rr      restriccion de resistencia
;

FO..    z =E=sum(i,x(i)*c(i));
Rnb(j)..   sum(i,x(i)*Datos(j,i))=G=Nvb(j);
Rna(j)..   sum(i,x(i)*Datos(j,i))=L=Nva(j);
Rr..    sum(i,x(i)*Res(i))=G=Req;

Model tallerpunto2 /ALL/;
option LP = CPLEX;
solve tallerpunto2 using LP minimizing z;
display x.l,z.l;

    
