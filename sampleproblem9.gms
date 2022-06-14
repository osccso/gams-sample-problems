SETS
         I NADADOR I /1,2,3,4,5,6,7,8,9,10/
         J ESTILO J /DORSO,PECHO,MARIPOSA,LIBRE/
;
PARAMETERS
         E(I)
         /
         1       15
         2       19
         3       18
         4       15
         5       17
         6       15
         7       15
         8       18
         9       16
         10      15
         /
         TABLE T(J,I)
                         1       2       3       4       5       6       7       8       9       10
         DORSO           36.5    32.7    33.7    27.4    27.6    38      21.3    37.7    38.9    36.6
         PECHO           22      30.1    40      38.4    29.2    42.2    40.2    22.2    41.9    29
         MARIPOSA        32.5    37.9    22.2    34      31.3    27.6    34.7    35.3    26.8    27.1
         LIBRE           39.3    39.1    34      42.7    41      26      36.3    42.6    26.4    32.7
;
VARIABLES
B(I,J) VARIABLE BINARIA QUE REPRESENTA LA ASIGNACION DEL NADADOR I AL ESTILO J
TMIN FUNCION OBJETIVO
;
BINARY VARIABLE B
;
EQUATIONS
FO FUNCION OBJETIVO
NESTILOS(I) NUMERO DE ESTILOS POR NADADOR
NASIGNADOS(J) NUMERO DE NADADORES ASIGNADOS POR ESTILO
MENOREDAD(J) EN CADA ESTILO AL MENOS UN MENOR DE EDAD
N2Y4(J) NADADORES 2 Y 4 SIEMPRE AL MISMO ESTILO
N9 NADADOR NUEVE NO PARTICIPA EN DORSO
TMENOR(I,J) LOS TIEMPOS DEBEN SER MENORES A 40
;
FO..     TMIN=E=SUM((I,J),B(I,J)*T(J,I));
NESTILOS(I)..    SUM(J,B(I,J))=E=2;
NASIGNADOS(J)..  SUM(I,B(I,J))=G=3;
MENOREDAD(J)..      B("1",J)+B("4",J)+B("6",J)+B("7",J)+B("9",J)+B("10",J)=G=1;
N2Y4(J)..        B("2",J)=E=B("4",J);
N9..             B("9","DORSO")=E=0;
TMENOR(I,J)..    T(J,I)*B(I,J)=L=40;
model SOL /all/;
solve SOL USING MIP MINIMIZING TMIN ;
display B.l;