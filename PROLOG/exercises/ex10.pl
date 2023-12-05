% 1.
% duplicatePrimes(L - list, R - result)
% duplicatePrimes(i, o) or (i, i)
% duplicatePrimes(L) = [], if L is []
%                    = H U duplicatePrimes(T), if H is not a prime
%                    = {H, H} U duplicatePrimes(T), otherwise

duplicatePrimes([], []).
duplicatePrimes([H|T], [H, H|R]) :-
    is_prime(H), !,
    duplicatePrimes(T, R).
duplicatePrimes([H|T], [H|R]) :-
    duplicatePrimes(T, R).

is_prime(0) :- !, fail.
is_prime(1) :- !, fail.
is_prime(2) :- !.
is_prime(3) :- !.
is_prime(N) :-
    N > 3,
    1 is N mod 2,
    not(has_factor(N, 3)).

has_factor(N, X) :-
    X * X =< N,
    0 is N mod X.
has_factor(N, X) :-
    X * X > N, !,
    fail.
has_factor(N, X) :-
    NextX is X + 2,
    has_factor(N, NextX).
