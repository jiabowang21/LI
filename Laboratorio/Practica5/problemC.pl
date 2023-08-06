variable(x).
variable(y).
variable(z).

instruccion([V1, =, V2, +, V3]):-
    variable(V1),
    variable(V2),
    variable(V3).
    
instruccion(I):-
    append([[if], [V1], [=], [V2], [then], INSTRUCCIONES1, [else], INSTRUCCIONES2, [endif]], I),
    variable(V1),
    variable(V2),
    instrucciones(INSTRUCCIONES1),
    instrucciones(INSTRUCCIONES2).
    
instrucciones(I):- instruccion(I).
instrucciones(INSTRUCCIONES):- append([I1, [;], I2], INSTRUCCIONES), instrucciones(I1), instrucciones(I2).

programa(P):- append([[begin], INSTRUCCIONES, [end]], P), instrucciones(INSTRUCCIONES), !.
