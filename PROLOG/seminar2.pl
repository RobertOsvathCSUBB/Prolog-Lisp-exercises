mulk([], _, []).
mulk([H|T], K, R) :-
    mulk(T, K, TR),
    NewHead is H * K,
    R = [NewHead|TR].

% addElem(L - list, E - elem, R - result list)
% addElem(i, i, o)
addElem([], E, [E]).
addElem([H|T], E, [H|TR]) :- 
    addElem(T, E, TR).

% insertElem(L - list, E - elem, M - position, R - result list)
% insertElem(i, i, i, o)
insertElem([], E, 1, [E]).
insertElem([], _, M, []) :- M > 1.
insertElem([H|T], E, 1, [E,H|T]).
insertElem([H|T], E, M, R) :-
    M1 is M-1,
    insertElem(T, E, M1, TR).

% delM(L - list, M - position, R - result list)
% delM(i, i, o)
delM([], _, []).
delM([M|T], M, TR):-
    delM(T, M, TR).
delM([H|T], M, [H|TR]):-
    H=\=M,
    delM(T, M, TR).


% sumC(L-list, C-collector, S-result)
% sumC(i, i, o)
sumC([], C, C).
sumC([H|T], C, R):-
    NewC is C+H,
    sumC(T, NewC, R).