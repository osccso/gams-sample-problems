$ontext
 Ajax Fuels, Inc. desarrolla un aditivo para los combustibles de avión, el cual es una mezcla de tres ingredientes: A, B y C.
 Para el desempeño apropiado, la cantidad total de aditivo (cantidad de A  cantidad de B  cantidad de C) debe ser por lo menos
 10 onzas por galón. Sin embargo, por razones de seguridad, la cantidad de aditivo no debe exceder de 15 onzas por galón de
 combustible. La mezcla de los tres ingredientes es crítica. Por lo menos 1 onza del ingrediente A debe usarse para cada onza
 del ingrediente B. La cantidad de ingrediente B debe ser por lo menos la mitad de la cantidad del ingrediente A. Si los costos
 onza para los ingredientes A, B y C son $0.10, $0.03 y $0.09, respectivamente, encuentre la mezcla de costo mínimo de A, B y C
 para cada galón de combustible de avión.

$offtext

SET
I IngredienteA;

PARAMETERS

ReqMin(J)   Reqmin por galón de 10 oz
ReqMax(J)   Reqmax por galón de 15 oz
CostoOz (J) Costo por onza de ingrediente i 
GalonC   Onzas por galón de combustible; 

VARIABLES
X(i) Cantidad de onzas a agregar de cada ingrediente I 
CostominG La función objetivo de minimizar los costos de los ingredientes i
*TENEMOS DUDAS ACERCA DE LAS VARIABLES, NO SABEMOS SI NOS FALTEN

Positive variable X;

Equations

FuncionObj La sumatoria de los ingredientes multiplicado por la varible y los costos por onza de ingrediente i 
Conversion Es que en un galón de combustible  es igual 128 onzas
ReqMinG Por cada galòn debe haber minimo 10 onzas de la sumatoria de los ingredientes
ReqMaxG Por cada galón de combustible debe haber minimo 15 onzas de ingredirentes aditivos
RequisitoMezcla(i) Para la mezcla del combustible es necesario que minimo una onza del ingrediente A se debe  agregar para cada onza del ingrediente B
RequisitoMD(i) Las onzas del ingrediente B deben ser mínimo la mitad de las onzas agregadas del ingrediente A;


FuncionObj..CostominG =e= CostoOz(i)* sum(i,X(i));
Conversion..X(i)=e=GalonC;
ReqMinG..sum(i,X(i))=g= ReqMin(i)* sum(i,X(i));
ReqMaxG..sum(i,X(i))=l= ReqMax(i)* sum(i,X(i));
RequisitoMezcla(i)$(ord(i)=1)..X(i+2)=g= X(i+1);
RequisitoMD(i)$(ord(i)=1)..sum(i,X(i+2)*0.5) =l= sum (i,X(i+1));


$include Datosajax2
model AJAX2/all/;

Solve AJAX2 minimazing CostominG using LP;
Display X.l, CostominG.l;

$ontext

Al principio se planteó este modelo con dos conjuntos el de ingredientes y el otro de combustible, pero decidimos que era
mejor dejarlo en un solo conjunto ya que en los parámetros  ninguno pertenecia al conjunto de combustible y otra duda y es que
si es estrictamente necesario hacer la convetrsiòn de galòn a onzas ya que como no nos estàn dando un inventario de
aditivos o el resto de conponenetes o solventes que componen al combustible.
$offtext 

