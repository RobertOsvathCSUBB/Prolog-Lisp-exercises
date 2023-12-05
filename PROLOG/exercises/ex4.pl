% 1.
% sum(L1 - first number, L2 - second number, X - overflowing number, R - result)
% sum(i, i, i, o) or (i, i, i, i)
% sum(L1, L2, X) = [], if L1 = [], L2 = []
%                = [(H1 + H2)%10 + X] + sum(T1, T2, (H1+H2)/10), otherwise

sum([], [], 0, []).
sum([H1|T1], [H2|T2], X, [H|R]) :-
    sum(T1, T2, X1, R),
    H is (H1 + H2 + X1) mod 10,
    X is (H1 + H2 + X1) // 10.

calcLength([], 0).
calcLength([H|T], R) :-
    calcLength(T, R1),
    R is R1 + 1.

fillWithZeros(0, []).
fillWithZeros(N, [0|R]) :-
    N1 is N - 1,
    fillWithZeros(N1, R).


add1ToNumber(L, 1, [1|L]).
add1ToNumber(L, 0, L).

concatenateLists([], L, L).
concatenateLists([H|T], L, [H|R]) :-
    concatenateLists(T, L, R).

sumWrapper(L1, L2, R) :-
    calcLength(L1, L1L),
    calcLength(L2, L2L),
    L1L > L2L,
    P is L1L - L2L,
    fillWithZeros(P, Z2),
    concatenateLists(Z2, L2, L2F),
    sum(L1, L2F, X, R1),
    add1ToNumber(R1, X, R).
sumWrapper(L1, L2, R) :-
    calcLength(L1, L1L),
    calcLength(L2, L2L),
    L1L < L2L,
    P is L2L - L1L,
    fillWithZeros(P, Z1),
    concatenateLists(Z1, L1, L1F),
    sum(L1F, L2, X, R1),
    add1ToNumber(R1, X, R).
sumWrapper(L1, L2, R) :-
    calcLength(L1, L1L),
    calcLength(L2, L2L),
    L1L =:= L2L,
    sum(L1, L2, X, R1),
    add1ToNumber(R1, X, R).

% 2.
% sum2(L - list, R - result)
% sum2(i, o) or (i, i)
% sum2(L) = [], if []
%         = sum2(T), if H is atomic
%         = sumWrapper(H, sum2(T)), otherwise

sum2([], []).
sum2([H|T], R) :-
    atomic(H),
    sum2(T, R).
sum2([H|T], R) :-
    sum2(T, R1),
    sumWrapper(H, R1, R).