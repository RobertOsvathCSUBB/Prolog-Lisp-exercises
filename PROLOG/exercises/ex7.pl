% 1.
% maxpos(L - list, R - result)
% maxpos(i, o) or (i, i)
% maxpos(L) = [], if L is []
%           = positions(H), if H is the maximum
%           = maxpos(L), otherwise

maxpos([], []).
maxpos(L, R) :-
    getMax(L, 0, K),
    positions(L, K, 1, R).

getMax([], C, C).
getMax([H|T], C, R) :-
    H > C, !,
    getMax(T, H, R).
getMax([H|T], C, R) :-
    getMax(T, C, R).

positions([], K, _, []).
positions([H|T], H, I, [I|R]) :-
    !, I1 is I+1,
    positions(T, H, I1, R).
positions([H|T], K, I, R) :-
    I1 is I+1,
    positions(T, K, I1, R).

% 2.
% maxpos2(L - list, R - result)
% maxpos2(i, o) or (i, i)
% maxpos2(L) = [], if L is []
%            = H + maxpos2(L), if H is atomic
%            = maxpos(H) + maxpos2(L), otherwise

maxpos2([], []).
maxpos2([H|T], [H|R]) :-
    atomic(H), !, 
    maxpos2(T, R).
maxpos2([H|T], [H1|R]) :-
    maxpos2(T, R),
    maxpos(H, H1).