% swipl

% pert(elem, l) elem pertany a la llista l

pert(X, [X|_]).                 % o bien X es el primero, o bien
pert(X, [_|L]):- pert(X, L).    % pertenece a la  lista de los demás

% concat(lli, ll2, ll3) ll3 és la concatenació de ll1 i ll2
% concat([a,b], [b,c,d], [a,b,b,c,d]) és cert
% concat([a,b], [b], [c, d]) és fals

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1, L2, L3).

% ejemplo
% ?- concat([a|L1], [X,Y|L2], [Z,b,c,d]).
% L1 = [[]],
% X = b,
% Y = c,
% L2 = [d],
% Z = a ;
% L1 = [[b, []]],
% X = c,
% Y = d,
% L2 = [],
% Z = a ;
% false.

fact(0,1).
fact(X,F):- X > 0, X1 is X - 1, fact(X1,F1), F is X * F1.

nat(0).
nat(N):- nat(N1), N is N1 + 1.

% mínimo común múltiplo (mcm) de dos números
mcm(X,Y,M):- nat(N), N>0, M is N * X, 0 is M mod Y.

long([],0). % longitud de una lista
long([_|L],M):- long(L,N), M is N+1.

factores_primos(1,[]) :- !.
factores_primos(N,[F|L]):- nat(F), F > 1, 0 is N mod F, N1 is N // F, factores_primos(N1,L),!.

pert_con_resto(X,L,Resto):- concat(L1,[X|L2], L ),
concat(L1, L2, Resto).

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

subcjto([],[]). %subcjto(L,S) es: "S es un subconjunto de L".
subcjto([X|C],[X|S]) :- subcjto(C,S).
subcjto([_|C],S) :- subcjto(C,S).

% subcjto([a,b,c],S), write(S), write(' '), fail.

cifras(L,N):- subcjto(L,S), permutacion(S,P), expresion(P,E), N is E, write(E),nl,fail.

expresion([X],X).
expresion(L,E1+E2):- concat(L1,L2,L), L1\=[],L2\=[],
expresion(L1,E1), expresion(L2,E2).
expresion(L,E1-E2):- concat(L1,L2,L), L1\=[],L2\=[],
expresion(L1,E1), expresion(L2,E2).
expresion(L,E1*E2):- concat(L1,L2,L), L1\=[],L2\=[],
expresion(L1,E1), expresion(L2,E2). 







