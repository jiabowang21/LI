
prod([], 1).
prod([X|L], P):- prod(L, P2), P is X * P2.

pescalar([], [], 0).
pescalar([X|L], [X2|L2], P):- pescalar(L, L2, P2), P is (X * X2) + P2.

pert(X, [X|_]).                 % o bien X es el primero, o bien
pert(X, [_|L]):- pert(X, L).    % pertenece a la  lista de los demás

interseccion([], _, []).
interseccion([X|L], L2, [X|L3]):- interseccion(L, L2, L3), pert(X, L2), !.
interseccion([_|L], L2, L3):- interseccion(L, L2, L3).

union([], X, X).
%union([X|L], L2, L3):- union(L, L2, L3), pert(X, L2), !.
%union([X|L], L2, [X|L3]):- union(L, L2, L3).
union([X|L1], L2, L):- member(X, L2), !, union(L1, L2, L).  %si el elemento X pertenece tanto a la lista L1 y L2, entonces solo ha de aparecer una vez a la lista L3
union([X|L1], L2, [X|L]):- union(L1, L2, L).  

concat([], L, L).
concat([X|L1], L2, [X|L3]):- concat(L1, L2, L3).

ultimo(L, X):- concat(_, [X], L).

inverso([],[]).
inverso(L, [X|L1]):- concat(L2,[X],L), inverso(L2,L1).



