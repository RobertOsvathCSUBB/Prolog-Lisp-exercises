% 1.
% subst(L - list, E - element, L1 - list to substitute with, R - result list)
% subst(i, i, i, o) or (i, i, i, i)
% subst(L, E, L1) = [], if L []
%                 = H + subst(T, E, L1), if H != E
%                 = L1 + subst(T, E, L1), if H == E

concatenateLists([], L2, L2).
concatenateLists([H|T], L2, [H|R]) :- concatenateLists(T, L2, R).

subst([], _, L1, []).
subst([H|T], H, L1, R) :-
    !,
    subst(T, H, L1, R1),
    concatenateLists(L1, R1, R).
subst([H|T], E, L1, [H|R]) :-
    subst(T, E, L1, R).


% 2.
% subst2(L - list, L1 - list to substitute with, R - result)
% subst(i, i, o) or (i, i, o)
% subst(L, L1) = [], if L is []
%              = H + subst(T, L1), if H is atomic
%              = subst([H1, T1], H1, L1) + subst2(T, L1), otherwise

getFirstElement([H|_], H).

subst2([], L1, []).
subst2([H|T], L1, [H|R]) :-
    atomic(H),
    !,
    subst2(T, L1, R).
subst2([H|T], L1, [R1|R]) :-
    subst2(T, L1, R),
    getFirstElement(H, K),
    subst(H, K, L1, R1).