remove_odd([], []).
remove_odd([H|T], [H|R]) :-
    0 is H mod 2, !,
    remove_odd(T, R).
remove_odd([H|T], R) :-
    remove_odd(T, R).

mountain([_], 1).
mountain([H1,H2|T], 0) :-
    H1<H2, 
    mountain([H2|T], 0).
mountain([H1,H2|T], _) :-
    H1>H2,
    mountain([H2|T], 1).

mountain_wrapper([H1,H2|T]) :-
    H1<H2,
    mountain([H2|T], 0).