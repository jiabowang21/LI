% EJERCICIOS

% 1. Escribe un predicado prod(L,P) que signifique: “P es el producto de los elementos de la lista de enteros dada L”. Debe poder generar la P y también comprobar una P dada.

prod([], 1).
prod([X|L], P):- prod(L, P1), P is P1 * X.

% 2. Escribe un predicado pescalar(L1,L2,P) que signifique: “P es el producto escalar de los vectores L1 y L2”, donde los vectores se representan como listas de enteros. El predicado debe fallar si los dos vectores tienen longitudes distintas

pescalar([],[], 0).
pescalar([X|L1], [Y|L2], P):- pescalar(L1, L2, P2), P is P2 + X * Y.

% 3. Representando conjuntos con listas sin repeticiones, escribe predicados para las operaciones de intersección y unión de conjuntos dados. pert(elem, l)

% pert(elem, l) elem pertany a la llista l
pert(X, [X|_]).                 % o bien X es el primero, o bien
pert(X, [_|L]):- pert(X, L).    % pertenece a la  lista de los demás

interseccion([], _ ,[]).    % interseccion de una lista vacía con cualquier otra, es la lista vacía
interseccion([X|L1], L2, [X|L3]):- pert(X,L2), !, interseccion(L1,L2,L3).   %si el elemento X pertenece a la lista L1 y L2, entonces ha de pertencer a la lista L3
interseccion([_|L1],L2,L3):- interseccion(L1,L2,L3).    %else: se hace la interseccion sin el primer el elemento de la lista L1


union([], L, L).    %union de una lista vacía con otra lista L, es L
union([X|L1], L2, L):- member(X, L2), !, union(L1, L2, L).  %si el elemento X pertenece tanto a la lista L1 y L2, entonces solo ha de aparecer una vez a la lista L3
union([X|L1], L2, [X|L]):- union(L1, L2, L).    %else: se hace la union del primer elemento con la lista L3

% union([X|L1],L2,L3):- pert(X,L2), !, union(L1,L2,L3).
% union([X|L1],L2,[X|L3]):- union(L1,L2,L3).

% 4. Usando concat, escribe un predicado para calcular el último elemento de una lista dada, y otro para calcular la lista inversa de una lista dada.

concat([], L, L).
concat([X|L1], L2, [X|L3]):- concat(L1, L2, L3).

ultimo(L, X):- concat(_, [X], L).
% L = [1,2,3] X 
% concat(_, [X], [1,2,3]) X es de un solo elemento y _ no nos interessa, por lo que _ solo puede ser [1,2] y X = [3], el ultimo elemento de la lista


% lista_inversa([],[]).
% lista_inversa([X], [X]).
% lista_inversa([X1|X], I):- X \= [], lista_inversa(X, I2), concat(I2, [X1], I).

inverso([],[]).
inverso(L, [X|L1]):- concat(L2,[X],L), inverso(L2,L1).

% 5. Escribe un predicado Prolog fib(N,F) que signifique “F es el Nésimo número de Fibonacci para la N dada”. Estos numeros se definen como: fib(1) = 1, fib(2) = 1, y, si N > 2, como: fib(N) = fib(N − 1) + fib(N − 2).

fib(1, 1):- !.
fib(2, 1):- !.
fib(N, F):- N > 2, N1 is N - 1, fib(N1, F1), N2 is N - 2, fib(N2, F2), F is F1 + F2 . 

% 6. Escribe un predicado Prolog dados(P,N,L) que signifique “la lista L expresa una manera de sumar P puntos lanzando N dados”. Por ejemplo: si P es 5, y N es 2, una solucion sería [1,4]. (Nótese que la longitud de L es N). Tanto P como N vienen instanciados. El predicado debe ser capaz de generar todas las soluciones posibles.

dados(0,0,[]).
dados(P, N, [X|L]):- N > 0, pert(X, [1,2,3,4,5,6]), Q is P - X, M is N - 1, dados(Q, M, L).

% 7. Escribe un predicado suma_demas(L) que, dada una lista de enteros L, se satisface si existe algún elemento en L que es igual a la suma de los demás elementos de L, y falla en caso contrario.
pert_con_resto(X, L, Resto):- concat(L1, [X|L2], L), concat(L1, L2, Resto).

suma([],0).
suma([X|L],S) :- suma(L,S1), S is S1+X.

suma_demas(L):- pert_con_resto(X, L, R), suma(R, X), !.

% 8. Escribe un predicado suma_ants(L) que, dada una lista de enteros L, se satisface si existe algún elemento en L que es igual a la suma de los elementos anteriores a él en L, y falla en caso contrario.

suma_ants(L) :- concat(L1, [X|_], L), suma(L1, X), !. 

% 9. Escribe un predicado card(L) que, dada una lista de enteros L, escriba la lista que, para cada elemento de L, dice cuántas veces aparece este elemento en L. Por ejemplo, card([1,2,1,5,1,3,3,7]) escribirá [[1,3],[2,1],[5,1],[3,2],[7,1]].

card([],[]).
card([X|L], [[X,N1]|Resto]):- card(L,C), pert_con_resto([X,N],C,Resto), !, N1 is N+1.
card([X|L], [[X,1]|C]):- card(L,C).

card(L):- card(L,C), write(C).

% 10. Escribe un predicado esta ordenada(L) que signifique: “la lista L de números enteros está ordenada de menor a mayor”. Por ejemplo, a la consulta:
% ?-esta_ordenada([3,45,67,83]). el intérprete responde yes, y a la consulta:
% ?-esta ordenada([3,67,45]). responde no.

esta_ordenada([]).
esta_ordenada([_]) :- !.
esta_ordenada([X, Y|L]):- X =< Y, esta_ordenada([Y|L]).


% 11. Escribe un predicado ord(L1,L2) que signifique: “L2 es la lista de enteros L1 ordenada de menor a mayor”. Por ejemplo: si L1 es [4,5,3,3,2] entonces L2 será [2,3,3,4,5]. Hazlo en una línea, usando sólo los predicados permutacion y esta_ordenada.

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

ord(L1, L2):- permutacion(L1, L2), esta_ordenada(L2).

% 12. Escribe un predicado diccionario(A,N) que, dado un alfabeto A de símbolos y un natural N, escriba todas las palabras de N símbolos, por orden alfabético (el orden alfabético es según el alfabeto A dado). Por ejemplo, diccionario( [ga,chu,le],2) escribirá: gaga gachu gale chuga chuchu chule lega lechu lele.

diccionario(A, N):-  nperts(A,N,S), escribir(S), fail.

nperts(_,0,[]):- !.
nperts(L, N, [X|S]):- pert(X,L), N1 is N-1, nperts(L,N1,S).

escribir([]):-write(' '),nl,!.
escribir([X|L]):- write(X), escribir(L).

% 13. Escribe un predicado palindromos(L) que, dada una lista de letras L, escriba todas las permutaciones de sus elementos que sean palíndromos (capicúas). Por ejemplo, con la consulta palindromos([a,a,c,c]) se escribe [a,c,c,a] y [c,a,a,c].

palindromos(L) :- permutacion(L,P), es_palindromo(P), write(P), nl, fail. 
palindromos(_). 

es_palindromo([]).
es_palindromo([_]) :- !. % regla adecuada
es_palindromo([X|L]) :- concat(L1,[X],L), es_palindromo(L1). 

% 14. Encuentra mediante un programa Prolog, usando el predicado permutación, que 8 dígitos diferentes tenemos que asignar a las letras S, E, N, D, M, O, R, Y, de manera que se cumpla la suma siguiente: S E N D + M O R E =  M O N E Y

suma([],[],[],C,C).
suma([X1|L1],[X2|L2],[X3|L3],Cin,Cout) :-
	X3 is (X1 + X2 + Cin) mod 10,
	C  is (X1 + X2 + Cin) //  10,
	suma(L1,L2,L3,C,Cout).


send_more_money1 :-

	L = [S, E, N, D, M, O, R, Y, _, _],
	permutacion(L, [0,1,2,3,4,5,6,7,8,9]),
	suma([D, N, E, S], [E, R, O, M], [Y, E, N, O], 0, M),

	write('S = '), write(S), nl,
	write('E = '), write(E), nl,
	write('N = '), write(N), nl,
	write('D = '), write(D), nl,
	write('M = '), write(M), nl,
	write('O = '), write(O), nl,
	write('R = '), write(R), nl,
	write('Y = '), write(Y), nl,
	write('  '), write([S,E,N,D]), nl,
	write('  '), write([M,O,R,E]), nl,
	write('-------------------'), nl,
	write([M,O,N,E,Y]), nl.


send_more_money2 :-

	L = [0,1,2,3,4,5,6,7,8,9],
	pert_con_resto(M,  [0,1], _),
	pert_con_resto(M,  L,  L0),
	pert_con_resto(O, L0, L1),
	pert_con_resto(R, L1, L2),
	pert_con_resto(Y, L2, L3),
	pert_con_resto(S, L3, L4),
	pert_con_resto(E, L4, L5),
	pert_con_resto(N, L5, L6),
	pert_con_resto(D, L6, _),
	suma([D, N, E, S], [E, R, O, M], [Y, E, N, O], 0, M),

	write('S = '), write(S), nl,
	write('E = '), write(E), nl,
	write('N = '), write(N), nl,
	write('D = '), write(D), nl,
	write('M = '), write(M), nl,
	write('O = '), write(O), nl,
	write('R = '), write(R), nl,
	write('Y = '), write(Y), nl,
	write('  '), write([S,E,N,D]), nl,
	write('  '), write([M,O,R,E]), nl,
	write('-------------------'), nl,
	write([M,O,N,E,Y]), nl.


% 20. Write in Prolog a predicate flatten(L,F) that “flattens” (cast.: “aplana”) the list F as in the example: ?-flatten( [a,b,[c,[d],e,[]],f,[g,h]], F ). F=[a,b,c,d,e,f,g,h]?

f([], []).
f([X|L], F):- f(X, PrimerObj), f(L, Resto), concat(PrimerObj, Resto, F), !.
f(X, [X]).

flatten(L, F):- f(L, F).

nat(0).
nat(N):- nat(N1), N is N1 + 1.

% 21. Escribe un predicado Prolog log(B,N,L) que calcula la parte entera L del logaritmo en base B de N, donde B y N son naturales positivos dados. Por ejemplo, ?- log(2,1020,L). escribe L=9? Podéis usar la exponenciación, como en 125 is 5**3. El programa (completo) no debe ocupar más de 3 lineas.
log(B, N, L):- nat(N1), A is B**N1, A > N, L is N1 - 1, !.

