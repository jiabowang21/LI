% Hacer aguas: disponemos de un grifo de agua, un cubo de 5 litros y otro de 8 litros.
% Se puede verter el contenido de un cubo en otro (hasta vaciar el primero, o hasta llenar el otro),
% llenar un cubo, o vaciar un cubo del todo. Escribir un programa Prolog que diga la secuencia
% más corta de operaciones para obtener exactamente 4 litros de agua en el cubo de 8 litros.

main:- EstadoInicial = [0,0], EstadoFinal = [0,4],
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

unPaso( 1, [N,M], [5,M] ):- N < 5. % omplir cub de 5
unPaso( 1, [N,M], [N,8] ):- M < 8. % omplir cub de 8
unPaso( 1, [N,M], [0,M] ):- N > 0. % buidar cub de 5
unPaso( 1, [N,M], [N,0] ):- M > 0. % buidar cub de 8

unPaso( 1, [N,M], [5,M2] ):- M > 0, N < 5, M2 is M-(5-N), M2 >= 0. % omplir completament el cub de 5 amb el de 8
unPaso( 1, [N,M], [N2,8] ):- N > 0, M < 8, N2 is N-(8-M), N2 >= 0. % omplir completament el cub de 8 amb el de 5
unPaso( 1, [N,M], [0,M2] ):- N > 0, M < 8, M2 is M+N, M2 < 8.      % omplir parcialment el cub de 8
unPaso( 1, [N,M], [N2,0] ):- N < 5, M > 0, N2 is M+N, N2 < 5.      % omplir parcialment el cub de 5



% 0 0
% 0 8
% 5 3
% 0 3
% 3 0
% 3 8
% 5 6
% 0 6
% 5 1
% 0 1
% 1 0
% 1 8
% 5 4
% 0 4

% 0 0
% 5 0
% 0 5
% 5 5
% 2 8
% 2 0
% 0 2
% 5 2
% 0 7
% 5 7
% 4 8
% 4 0
% 0 4
