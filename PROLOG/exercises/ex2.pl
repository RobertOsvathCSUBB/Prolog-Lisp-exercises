% 1.
% sort_list(L - list, CL - copy, R - result)
% flow model: (i o), (i i)

sort_list([], []).
sort_list([H|T], R):-
    sort_list(T, R1),
    insert_into(R1, H, R).

% insert_into(L - list, E - element, R - result)
% flow model: (i i o), (i i i)

insert_into([], E, [E]).
insert_into([H|T], E, [E, H|T]):-
    E =< H,
    !.
insert_into([H|T], E, [H|R]):-
    insert_into(T, E, R).

% 2.
% sort_list_heterogeneous(L - list, R - result)
% flow model: (i o), (i i)

sort_list_heterogeneous([], []).
sort_list_heterogeneous([H|T], [H|R]):-
    atomic(H),
    !,
    sort_list_heterogeneous(T, R).
sort_list_heterogeneous([H|T], [HR|R]):-
    is_list(H),
    !,
    sort_list(H, HR),
    sort_list_heterogeneous(T, R).