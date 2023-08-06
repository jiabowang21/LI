%solucio(_). 
solucio(L):-
    L = [ [1,_,_,_,_,_], [2,_,_,_,_,_], [3,_,_,_,_,_], [4,_,_,_,_,_], [5,_,_,_,_,_] ],
    
    % [numcasa,color,profesión,animal,bebida,pais] 
    
    % 1 - El que vive en la casa roja es de Perú
    member([_,roja,_,_,_,peru], L),
    
    % 2 - Al francés le gusta el perro
    member([_,_,_,perro,_,francia], L),
    
    % 3 - El pintor es japonés
    member([_,_,pintor,_,_,japon], L),
    
    % 4 - Al chino le gusta el ron
    member([_,_,_,_,ron,china], L),
    
    % 5 - El húngaro vive en la primera casa
    member([1,_,_,_,_,hungria], L),
    
    % 6 - Al de la casa verde le gusta el coñac
    member([N,verde,_,_,coñac,_], L),
    
    % 7 - La casa verde está justo a la izquierda de la blanca
    N2 is N + 1, N < 5,
    
    member([N2,blanca,_,_,_,_], L),
    
    % 8 - El escultor cría caracoles
    member([_,_,escultor,caracol,_,_], L),
    
    % 9 - El de la casa amarilla es actor
    member([X,amarilla,actor,_,_,_], L),
    
    % 10 - El de la tercera casa bebe cava
    member([3,_,_,_,cava,_], L),
    
    % 11 - El que vive al lado del actor tiene un caballo
    (P2 is X + 1 | P2 is X - 1), member(P2, [1,2,3,4,5]),
    member([P2,_,_,caballo,_,_],L),
    
    % 12 - El húngaro vive al lado de la casa azul
    member([2,azul,_,_,_,_], L),
    
    % 13 - Al notario la gusta el whisky
    member([_,_,notario,_,whisky,_], L),
    
    % 14 - El que vive al lado del médico tiene un ardilla,
    member([V,_,medico,_,_,_], L),
    (P3 is V + 1 | P3 is V - 1), member(P3, [1,2,3,4,5]),
    member([P3,_,_,ardilla,_,_],L),
    
    displaySol(L),
    fail.
    
displaySol(L):- member(P,L), write(P), nl, fail.
displaySol(_).
