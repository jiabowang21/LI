:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

%Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
    %1: Vars + Domini:
    length(D1,6),
    length(D2,6),
    length(D3,6),
    length(D4,6),
    append( [D1, D2, D3, D4], Vars ),
    Vars ins 1..24,
    all_distinct(Vars),
    
    %2: Constraints:
    sorted(D1),
    sorted(D2),
    sorted(D3),
    sorted(D4),
    D1 = [D11|_], D11 #= 1,
    D2 = [D21|_], D21 #= 2,
    D3 = [D31|_],
    D4 = [D41|_], D31 #< D41,
    computeIncompatiblesPairs(L),       % L es la llista de parelles de lletres que no han de sortir en el mateix dau (els incompatibles)
    %write(L),
    makeConstraints(D1,L),              % les parelles de lletres incompatibles no poden estar a D1
    makeConstraints(D2,L),              % les parelles de lletres incompatibles no poden estar a D2
    makeConstraints(D3,L),              % les parelles de lletres incompatibles no poden estar a D3
    makeConstraints(D4,L), !,             % les parelles de lletres incompatibles no poden estar a D4
    
    %3: Labeling:
    labeling([ff], Vars),
    
    %4: Write:
    writeN(D1), 
    writeN(D2), 
    writeN(D3), 
    writeN(D4), halt.
    
makeConstraints(_,[]).
makeConstraints([A,B,C,D,E,F], [N-M|L]):-
    A #\= N #\/ B #\= M, A #\= N #\/ C #\= M, A #\= N #\/ D #\= M, A #\= N #\/ E #\= M, A #\= N #\/ F #\= M,
    B #\= N #\/ C #\= M, B #\= N #\/ D #\= M, B #\= N #\/ E #\= M, B #\= N #\/ F #\= M,
    C #\= N #\/ D #\= M, C #\= N #\/ E #\= M, C #\= N #\/ F #\= M,
    D #\= N #\/ E #\= M, D #\= N #\/ F #\= M,
    E #\= N #\/ F #\= M, 
    makeConstraints([A,B,C,D,E,F], L), !.

writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.

sorted([_]).
sorted([A,B|L]):- A #< B, sorted([B|L]).

computeIncompatiblesPairs(L):- findall( N-M, notInSameDice(N,M), L ).

notInSameDice(N,M):- word(W), member(A,W), member(B,W), num(A,N), num(B,M), N #< M.

%leftmost
%Label the variables in the order they occur in Vars. This is the default.
%ff
%First fail. Label the leftmost variable with smallest domain next, in order to detect infeasibility early. This is often a good strategy.
%ffc
%Of the variables with smallest domains, the leftmost one participating in most constraints is labeled next.
%min
%Label the leftmost variable whose lower bound is the lowest next.
%max
%Label the leftmost variable whose upper bound is the highest next.
%The value order is one of:

%up
%Try the elements of the chosen variable's domain in ascending order. This is the default.
%down
%Try the domain elements in descending order.
%The branching strategy is one of:

%step
%For each variable X, a choice is made between X = V and X #\= V, where V is determined by the value ordering options. This is the default.
%enum
%For each variable X, a choice is made between X = V_1, X = V_2 etc., for all values V_i of the domain of X. The order is determined by the value ordering options.
%bisect
%For each variable X, a choice is made between X #=< M and X #> M, where M is the midpoint of the domain of X.
