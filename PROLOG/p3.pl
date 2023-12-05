% generateString(L - [-1, 0 ,1], [H|T] - same as L, N - n, R - result string)
% - generate a string of characters 0, 1, and -1, of length 2*n+1, where |a(i+1)-ai| = 1 or 2
% generateString(i,i,i,o) or generateString(i,i,i,i)
% generateString(L, N) = result, if N=0
%                      = H U generateString(L, N-1), if index < 2*n+1 and H is in possible elements
%                      = generateString(T, N), otherwise

generateString(_, [], _, []) :- fail.
generateString(_, _, 0, []) :- !.
generateString(L, [H|T], N, [H|R]) :-
    getPossibleElements(L, H, P),
    N1 is N-1,
    generateString(L, P, N1, R).
generateString(L, [H|T], N, R) :-
    generateString(L, T, N, R).


% getPossibleElements(i, i, o) or (i, i, i)

getPossibleElements([], _, []).
getPossibleElements([H|T], H, R) :- 
    !,
    getPossibleElements(T, H, R).
getPossibleElements([H|T], K, [H|R]) :-
    getPossibleElements(T, K, R).



wrapper(N, R) :-
    N1 is 2*N+1,
    findall(RT, generateString([-1,0,1], [-1,0,1], N1, RT), R).
    
