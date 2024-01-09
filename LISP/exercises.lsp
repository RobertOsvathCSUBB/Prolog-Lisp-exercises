(
    defun f (l1 l2)
    (cond
        ((listp l1) (append (f (car l1) l2)
                        (cond
                            ((null l1) (cdr l2))
                            (t (list (f (car l1) l2) (car l2)))
                        )
                    ))
        (t (cons l1 l2))
    )
)

(let ((l1 '(1 2 3 4)) (l2 '(5 6 7 8)))
    (princ (f l1 l2))
)