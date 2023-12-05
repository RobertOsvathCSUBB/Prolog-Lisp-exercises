% 1.
% add(L - list, E - element, M - index, R - resulting list)
% add(i, i, i, o)

% add(list, element, index) = [] if list is empty,
%                           = head U element U add(tail, element, index + 1), if index is 1 or 3 or 5 or 7 or 15
%                           = head U add(tail, element, index + 1), otherwise 

isPos(1).
isPos(3).
isPos(7).
isPos(15).

add([], _, _, []).
add([H|T], E, M, [H, E|R]) :-
    isPos(M),
    M1 is M + 1,
    add(T, E, M1, R).
add([H|T], E, M, [H|R]) :-
    M =\= 1, M =\= 3, M =\= 7, M =\= 15,
    M1 is M + 1,
    add(T, E, M1, R).

addMain(L, E, R) :-
    add(L, E, 1, R).


% 2.
% add2(L - list, E - current last element, R - resulting list)
% add2(i, i, o)

% add2(list) = [] if list is empty
%            = head U add2(tail), if head is not a list
%            = addMain(head, preavious head) U add2(tail), otherwise

add2([], _, []).
add2([H|T], _, [H|R]):-
    not(is_list(H)),
    add2(T, H, R).
add2([H|T], E, [R1|R]):-
    is_list(H),
    addMain(H, E, R1),
    add2(T, E, R).

add2Main([H|T], R) :-
    add2([H|T], H, R).
