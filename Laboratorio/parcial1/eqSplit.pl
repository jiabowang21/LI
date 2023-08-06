%% Write a Prolog predicate eqSplit(L,S1,S2) that, given a list of
%% integers L, splits it into two disjoint subsets S1 and S2 such that
%% the sum of the numbers in S1 is equal to the sum of S2. It should
%% behave as follows:
%%
%% ?- eqSplit([1,5,2,3,4,7],S1,S2), write(S1), write('    '), write(S2), nl, fail.
%%
%% [1,5,2,3]    [4,7]
%% [1,3,7]    [5,2,4]
%% [5,2,4]    [1,3,7]
%% [4,7]    [1,5,2,3]


main:- eqSplit([1,5,2,3,4,7],S1,S2), write(S1), write('    '), write(S2), nl, fail.
main.

suma([],0).
suma([X|L],S) :- suma(L,S1), S is S1+X.

per([], [], []).
per([X|L], [X|S1], S2):- per(L, S1, S2). 
per([X|L], S1, [X|S2]):- per(L, S1, S2).

eqSplit(L, S1, S2):- per(L, S1, S2), suma(S1, S11), suma(S2, S22), S11 == S22.
