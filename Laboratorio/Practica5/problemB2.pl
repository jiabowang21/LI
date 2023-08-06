% Buscamos la manera más r´apida para tres misioneros y tres caníbales de cruzar un río
% en una canoa que puede ser utilizada por 1 ó 2 personas (misioneros o caníbales), pero siempre
% evitando que los misioneros queden en minoría en cualquier orilla (por razones obvias).

% estat = [ML, CL, S]
% 0 -> esquerra // 1 -> dreta
main:- EstadoInicial = [3,3,0], EstadoFinal = [0,0,1],
    between(1,1000,CosteMax), % Buscamos solución de coste 0; si no, de 1, etc.
    camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
    reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    CosteMax>0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
    \+member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).

% sempre el numero de ML ha de ser major que el numero de CL quan es major que 1. (3 - ML) - (3 - CL) >= 0; 3 - ML - 3 + CL >= 0; CL - ML >= 0
esCorrecte(ML, CL, _):- T is ML - CL, (T >= 0 | ML is 0 | CL is 0), T2 is CL - ML, (T2 >= 0 | ML is 3 | CL is 3).

% NCC -> numero de persones que poden utilitzar el canova (entre 1 i 2), NM ha d'estar entre 0 i 2 i NC tambe. NCC = NM + NC
canova(NM, NC):- between(1,2,NCC), between(0,2,NM), between(0,2,NC), NCC is NM + NC.

% creuar desde l'esquerra a la dreta 
unPaso(1, [ML, CL, 0], [ML2, CL2, 1]):- canova(NM,NC), M is ML - NM, M >= 0, C is CL - NC, C >= 0, ML2 is ML - NM, 3 - ML2 >= 0, CL2 is CL - NC, CL2 >= 0, esCorrecte(ML2, CL2, _).

% creuar desde la dreta a l'esquerra
unPaso(1, [ML, CL, 1], [ML2, CL2, 0]):- canova(NM,NC), M is 3 - ML - NM, M >= 0, C is 3 - CL - NC, C >= 0, ML2 is ML + NM, ML2 =< 3, CL2 is CL + NC, CL2 =< 3, esCorrecte(ML2, CL2, _).

