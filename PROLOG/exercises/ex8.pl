% 1.
% successor(L - list, R - result)
% successor(i, o) or (i, i)
% successor(L) = [], if L is []
%              = overflow + successor(L), otherwise

successor(L, R) :-
    sum(L, X, R1),
    X is 1, !,
    R = [1|R1].
successor(L, R) :-
    sum(L, X, R).

sum([H], X, [H1]) :- 
    H1 is (H+1) mod 10,
    X is (H+1) // 10.
sum([H|T], X1, [H1|R]) :-
    sum(T, X, R),
    H1 is (H+X) mod 10,
    X1 is (H+X) // 10.

% 2.
% successorForSublists(L - list, R - result)
% successorForSublists(i, o) or (i, i)
% successorForSublists(L) = [], if L is []
%                         = H + successorForSublists(T), if H is atomic
%                         = successor(H) + successorForSublists(T), otherwise

successorForSublists([], []).
successorForSublists([H|T], [H|R]) :-
    atomic(H), !, 
    successorForSublists(T, R).
successorForSublists([H|T], [H1|R]) :-
    successorForSublists(T, R),
    successor(H, H1).