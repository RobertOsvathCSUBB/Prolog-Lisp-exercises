% 1.
% nrOccurences(L - list, E - elem, R - number of occurences)
% nrOccurences(i, i, o) or (i, i, i)

nrOccurences([], _, 0).
nrOccurences([H|T], H, R) :-
    !,
    nrOccurences(T, H, R1),
    R is R1 + 1.
nrOccurences([H|T], E, R) :-
    nrOccurences(T, E, R).

% 2.
% nrOccurences2(L - list, E - elem, C - collector, R - number of occurences)
% nrOccurences2(i, i, i, o) or (i, i, i, i)

nrOccurences2([], E, C, C).
nrOccurences2([H|T], H, C, R) :-
    C1 is C + 1,
    nrOccurences2(T, H, C1, R).
nrOccurences2([H|T], E, C, R) :-
    H =\= E,
    nrOccurences2(T, E, C, R).

main(L, E, R) :-
    nrOccurences2(L, E, 0, R).

% 3.
% removeUnique(L - list, Cop - copy of the list, R - result list)
% removeUnique(i, o) or (i, i)

removeUnique([], _, []).
removeUnique([H|T], Cop, R) :-
    nrOccurences(Cop, H, 1),
    removeUnique(T, Cop, R).
removeUnique([H|T], Cop, [H|R]) :-
    not(nrOccurences(Cop, H, 1)),
    removeUnique(T, Cop, R).

mainRemove(L, R) :-
    removeUnique(L, L, R).

% 4.
% gcd(A, B, R).
% gcd(i, i, o) or (i, i, i).

gcd(A, 0, A).
gcd(A, B, R) :-
    C is A mod B,
    gcd(B, C, R).

% gcdL(L - list, R - result)
% gcdL(i, o) or (i, i)

gcdL([H], H).
gcdL([H1, H2|T], R) :-
    gcd(H1, H2, C),
    gcdL([C|T], R).