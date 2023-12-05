% 1.
% mul(L - number as list, K - factor, X - overflow, R - result)
% mul(i, i, o, o) or (i, i, i, i)
% mul(L, K) = [], if L = []
%           = ((H*K) mod 10 + X) + mul(T, K), otherwise, and X will be (H*K)//10

mul([], _, 0, []).
mul([H|T], K, X1, [H1|R]) :-
    mul(T, K, X, R),
    H1 is (H*K+X) mod 10,
    X1 is (H*K+X) // 10.

concatenate([], L, L).
concatenate([H|T], L, [H|R]) :- concatenate(T, L, R).

mulWrapper(L, K, R) :-
    mul(L, K, X, R),
    X =:= 0, !.
mulWrapper(L, K, R) :-
    mul(L, K, X, R1),
    concatenate([X], R1, R).

% maxElements(L - list, R - result)
% maxElements(i, o) or (i, i)
% maxElements(L) = [], if L is []
%                = H + maxElements(T), if H is atomic
%                = maxPositions(H) + maxElements(L), otherwise

maxElements([], []).
maxElements([H|T], [H|R]) :-
    atomic(H),
    !,
    maxElements(T, R).
maxElements([H|T], [H1|R]) :-
    maxElements(T, R),
    getMax(H, 0, K),
    filterMaxPositions(H, K, 1, H1).

getMax([], C, C).
getMax([H|T], C, R) :-
    H > C, !,
    getMax(T, H, R).
getMax([H|T], C, R) :-
    getMax(T, C, R).

filterMaxPositions([], K, _, []).
filterMaxPositions([H|T], H, I, [I|R]) :-
    I1 is I+1,
    filterMaxPositions(T, H, I1, R).
filterMaxPositions([H|T], K, I, R) :-
    I1 is I+1,
    filterMaxPositions(T, K, I1, R).
