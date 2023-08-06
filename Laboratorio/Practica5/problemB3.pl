%B.3. Trata de averiguar la manera más rápida que tienen cuatro personas P1, P2, P5 y
%P8 para cruzar de noche un puente que sólo aguanta el peso de dos, donde tienen una única e
%imprescindible linterna y cada Pi tarda i minutos en cruzar. Dos juntos tardan como el más
%lento de los dos.

main:- EstadoInicial = [[1, 2, 5, 8], 'L'], EstadoFinal = [[], 'R'],
    between(1,1000,CosteMax), % Buscamos solución de coste 0; si no, de 1, etc.
    camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
    reverse(Camino,Camino1), write(Camino1), write(" con coste "), write(CosteMax), nl, halt.

    
camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    CosteMax>0,
    unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
    \+member( EstadoSiguiente, CaminoHastaAhora ),
    CosteMax1 is CosteMax-CostePaso,
    camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).

%todas las combinaciones posibles
permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

%pertenecer
pert(X,[X|_]). % o bien X es el primero, o bien
pert(X,[_|L]):- pert(X,L). % pertenece a la lista de los demas

concat([],L,L).
concat([X|L1],L2,[X|L3]) :- concat(L1,L2,L3).

% Pertenece con resto: X esta en la lista L, R es la lista L sin X.
pert_con_resto(X,L,R) :- concat(L1,[X|L2],L), concat(L1,L2,R). 

% R es la lista de elementos de L1 que no esta en L2
not_member([], _, []).
not_member(L1, [], L1).
not_member(L1, L2, [X|R]):- pert_con_resto(X, L1, L11), not(member(X, L2)), not_member(L11, L2, R), !.
not_member(L1, L2, R):- pert_con_resto(X, L1, L11), member(X, L2), not_member(L11, L2, R), !.
    
max(X, Y, R):- member(R, [X,Y]), not_member([X, Y], [R], [MIN]), R >= MIN. 

% Va 1 persona 
unPaso(CosteMax, [L1, 'L'], [L2, 'R']):- pert_con_resto(P1, L1, L2), CosteMax is P1.

% Van 2 personas
unPaso(CosteMax, [L1, 'L'], [L2, 'R']):- pert_con_resto(P1, L1, Laux), pert_con_resto(P2, Laux, L2), max(P1, P2, CosteMax).

% Vuelve 1 persona
unPaso(CosteMax, [L1, 'R'], [L2, 'L']):- not_member([1,2,5,8], L1, R), pert_con_resto(P1, R, _), concat([P1], L1, L2), CosteMax is P1.

% Vuelven 2 personas
unPaso(CosteMax, [L1, 'R'], [L2, 'L']):- not_member([1,2,5,8], L1, R), pert_con_resto(P1, R, RX), pert_con_resto(P2, RX, _), concat([P1, P2], L1, L2), max(P1, P2, CosteMax).
