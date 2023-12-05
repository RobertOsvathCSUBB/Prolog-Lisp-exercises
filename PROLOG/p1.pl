% 1.
% toSet(L - list, R - resulting set)
% toSet(i, o) or toSet(i, i)

notContains([], _).
notContains([H|T], E):-
    H =\= E,
    notContains(T, E).

% toSet(list, result) = [], if list = [],
%                     = toSet(tail, result), if the result contains the head,
%                     = head U toSet(tail, result), otherwise

toSet([], C, C).
toSet([H|T], C, R):-
    notContains(C, H),
    !,
    toSet(T, [H|C], R).

toSet([_|T], C, R):-
    toSet(T, C, R).

toSetWrapper(L, R):-
    toSet(L, [], R).


% 2.
% evenOrOdd(L - list, R1 - list of even numbers, R2 - list of odd numbers)
% evenOrOdd(i, o, o) or evenOrOdd(i, i, i)

% evenOrOdd(list) = [] and [], if list = [],
%                 = head U evenOrOdd(tail) and evenOrOdd(tail), if head is even,
%                 = evenOrOdd(tail) and head U evenOrOdd(tail), if head is odd

evenOrOdd([], [], []).
evenOrOdd([H|T], [H|R1], R2):-
    0 is H mod 2,
    evenOrOdd(T, R1, R2).

evenOrOdd([H|T], R1, [H|R2]):-
    1 is H mod 2,
    evenOrOdd(T, R1, R2).