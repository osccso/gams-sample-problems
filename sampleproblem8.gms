$ontext
 Se deben transportar 20 millones de barriles de petróleo desde Dhahran en Arabia
Saudita a las ciudades de Rotterdam, Marsella y Nápoles en Europa. Las demandas de
 estas tres ciudades son 4, 12 y 4 millones de barriles, respectivamente.
La ruta que une Dhahran y Marsella no puede transportar más de 3 millones de barriles
debido a ciertos acuerdos comerciales. Por otro lado, existe la posibilidad que se
 realice una detención, ya sea en el puerto de Alejandría o Suez, donde la capacidad
 de almacenamiento es de 8 y 10 millones respectivamente. Por último, observe que
es posible enviar barriles de petróleo desde Marsella a Nápoles. Sin embargo,
le está prohibido a Nápoles recibir más petróleo de Marsella que directamente de Dhahran


las rutas y los costos por ruta son los siguientes

Dhahran->Alejandria   $6
Dhahran->Marsella     $8
Dhahran->Suez         $5
Dhahran->Rotterdam    $7
Dhahran->Napoles      $15
Alejandria-Rotterdam  $8
Alejandria-Marsella   $7
Suez->Marsella        $2
Suez->Napoles         $6
Marsella->Napoles     $1

$offtext

sets  i ciudades /Dhahran,Alejandria,Suez,Rotterdam,Marsella,Napoles/
      pto(i) puertos /Rotterdam,Marsella,Napoles/
      tr(i)  transbordos /Alejandria,Suez/
;

alias (i,ip);

parameters
Cap(tr) capacidad en los transbordos
/
Alejandria       8
Suez             10
/
Dem(pto) demanda en los puertos
/
Rotterdam        4
Marsella         12
Napoles          4
/

;
table Costos(i,ip) costos de transporte
                 Dhahran         Alejandria      Suez    Rotterdam       Marsella        Napoles
Dhahran          1E9             6               5       7               8               15
Alejandria       1E9             1E9             1E9     8               7               1E9
Suez             1E9             1E9             1E9     1E9             2               6
Rotterdam        1E9             1E9             1E9     1E9             1E9             1E9
Marsella         1E9             1E9             1E9     1E9             1E9             1
Napoles          1E9             1E9             1E9     1E9             1E9             1E9
;
variables
CT FUNCION OBJETIVO COSTO TOTAL
x(i,ip) CANTIDAD A transportar desde ciudad i hasta ciudad ip
;
positive variable x;

equations
FO funcion objetivo
R1(pto) DEMANDA EN LOS PUERTOS
R2(tr) balance en transbordos
R3(tr) capacidad en los transbordos
R4 capacidad de la ruta entre Dhahran y marsella
R5 no se puede recibir mas pretoleo de marsella que de Dhahran en Napoles
;
FO..     CT=E=sum((i,ip),Costos(i,ip)*x(i,ip));
R1(pto)..         sum(i,x(i,pto))-sum(i,x(pto,i))=G=Dem(pto);
R2(tr)..        sum(i,x(i,tr))=E=sum(i,x(tr,i));
R3(tr)..        sum(i,x(i,tr))=L=Cap(tr);
R4..            x("Dhahran","Marsella")=L=3;
R5..            x("Dhahran","Napoles")=G=x("Marsella","Napoles");

model pempres/all/;
solve pempres using LP minimizing CT;
display x.l;

$ontext
la solucion obtenida es

Optimal solution found
Objective:          167.000000 que es el costo total en millones $

y la forma en que se deben programar el transporte de los barriles para garantizar
este costo minimo es la siguiente.

----     81 VARIABLE x.L  CANTIDAD A transportar desde ciudad i hasta ciudad ip

            Alejandria        Suez   Rotterdam    Marsella     Napoles

Dhahran          1.000      10.000       4.000       3.000       2.000
Alejandria                                           1.000
Suez                                                10.000
Marsella                                                         2.000
$offtext
