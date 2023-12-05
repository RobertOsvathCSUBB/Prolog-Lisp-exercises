% 1.
% merge_lists(L1 - list, L2 - list, R - result)
% flow model: (i, i, o)
% 
% merge_lists(l1, l2, r) = l1, if l2 is empty
%                        = l2, if l1 is empty
%                        = l1[0] + merge_lists(l1[1...n], l2[1...m]), if l1[0] = l2[0]
%                        = l1[0] + l2[0] + merge_lists(l1[1...n], l2[0...m]), otherwise

merge_lists([], [], []).
merge_lists([], L2, L2).
merge_lists(L1, [], L1).
merge_lists([H1|T1], [H1|T2], [H1|R]):-
    !,
    merge_lists(T1, T2, R).
merge_lists([H1|T1], [H2|T2], [H1|R]):-
    H1 < H2,
    !,
    merge_lists(T1, [H2|T2], R).
merge_lists([H1|T1], [H2|T2], [H2|R]):-
    merge_lists([H1|T1], T2, R).

% 2.
% merge_heterogeneous_list(L - list, R - result)
% flow model: (i, o) or (i, i)
%
% merge_heterogeneous_list(l, r) = [], if l is empty
%                                = l[0][0] + l[0][1] + ... + l[0][n] + merge_heterogeneous_list(l[1...n]), if l[0] is list
%                                = l[0] + merge_heterogeneous_list(l[1...n]), if l[0] is number

merge_heterogeneous_list([], []).
merge_heterogeneous_list([H|T], [H|R]):-
    number(H),
    !,
    merge_heterogeneous_list(T, R).
merge_heterogeneous_list([H|T], R):-
    merge_heterogeneous_list(T, R1),
    removeDuplicates(H, R2).
    merge_lists(R2, R1, R).