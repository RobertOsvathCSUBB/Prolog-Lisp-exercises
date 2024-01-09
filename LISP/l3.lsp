(
    defun my-append (lst1 lst2)
    (cond
        ((null lst1) lst2)
        ((null lst2) lst1)
        (t (cons (car lst1) (my-append (cdr lst1) lst2)))
    )
)

; reverse-list(l1l2...ln) = nil, if n = 0
;                         = reverse-list(l2...ln) U [l1], otherwise
(
    defun reverse-list (lst)
    (cond
        ((null lst) nil)
        (t (my-append (reverse-list (cdr lst)) (list (car lst))))
    )
)

; reverse-multilevel-list(x) = nil, if x is null
;                            = x, if x is an atom
;                            = reverse-multilevel-list(reverse-list(l1)) U reverse-multilevel-list(reverse-list(l2)) U ...
;                             U reverse-multilevel-list(reverse-list(ln)), otherwise, x = l1l2l3...ln
(
    defun reverse-multilevel-list (x)
    (cond
        ((null x) nil)
        ((atom x) x)
        (t (mapcar #'reverse-multilevel-list (reverse-list x)))
    )
)

(let ((x '(1 (2 3) 4 (5 (6 7) 8) 9)))
    (format t "The original list is: ")
    (princ x)
    (fresh-line)
    (format t "The reversed list is: ")
    (princ (reverse-multilevel-list x))
)