; The program finds the level of a binary tree which contains the most elements and prints them

; my append function
(
    defun my-append (lst1 lst2)
    (cond
        ((null lst1) lst2)
        ((null lst2) lst1)
        (t (cons (car lst1) (my-append (cdr lst1) lst2)))
    )
)

; flatten-one-level(l1l2...ln) = nil, if list is empty
;                              = flatten-one-level(l2ll3...ln), if l1 is an atom
;                              = l1 U flatten-one-level(l2l3...ln), if l1 is a list
(
    defun flatten-one-level (lst)
    (cond
        ((null lst) nil)
        ((atom (car lst)) (flatten-one-level (cdr lst)))
        (t (my-append (car lst) (flatten-one-level (cdr lst))))
    )
)

; get-elems-of-level-rec(l1l2...ln, level, current-level) = nil, if list is empty
;                                                         = l1 U get-elems-of-level-rec(l2l3...ln, level, current-level), 
;                                                                          if l1 is an atom and current-level = level
;                                                         = get-elems-of-level-rec(l2l3...ln, level, current-level),
;                                                                          if l1 is a list and current-level = level
;                                                         = get-elems-of-level-rec(flatten-one-level(l1l2...ln), level, current-level + 1),
;                                                                          otherwise
; get-elems-of-level(lst, level) = get-elems-of-level-rec(lst, level, 0)
(
    defun get-elems-of-level (lst level)
    (labels (
            (get-elems-of-level-rec (lst level current-level)
                (cond
                    ((null lst) nil)
                    ((and (= current-level level) (atom (car lst))) (cons (car lst) (get-elems-of-level-rec (cdr lst) level current-level)))
                    ((and (= current-level level) (listp (car lst))) (get-elems-of-level-rec (cdr lst) level current-level))
                    (t (get-elems-of-level-rec (flatten-one-level lst) level (+ current-level 1)))
                )
            ))
        (get-elems-of-level-rec lst level 0)
    )
)

; calc-length-rec(l1l2...ln, length) = length, if list is empty
;                                    = calc-length-rec(l2l3...ln, length + 1), otherwise
; calc-length(lst) = calc-length-rec(lst, 0)
(
    defun calc-length (lst)
    (labels ((calc-length-rec (lst length)
                (cond 
                    ((null lst) length)
                    (t (calc-length-rec (cdr lst) (+ length 1)))
                )
        ))
        (calc-length-rec lst 0)
    )
)

; get-level-rec(aux, level, max-level, max-elems) = max-level, if aux is empty
;                                                 = get-level-rec(get-elems-of-level(lst, level + 1), level + 1, level, level-elems),
;                                                                    if level-elems > max-elems
;                                                 = get-level-rec(get-elems-of-level(lst, level + 1), level + 1, max-level, max-elems),
;                                                                    otherwise
; get-level(lst) = get-level-rec(get-elems-of-level(lst, 0), 0, 0, 0)
; aux always contains the elements of the current level, starting from level 0
(
    defun get-level-with-max-elements (lst)
    (labels (
        (get-level-rec (aux level max-level max-elems)
            (cond
                ((null aux) max-level)
                (t
                    (let ((level-elems (calc-length aux)))
                        (if (> level-elems max-elems)
                            (progn
                                (setq max-elems level-elems)
                                (setq max-level level)
                            )
                        )
                        (get-level-rec (get-elems-of-level lst (+ level 1)) (+ level 1) max-level max-elems) 
                    )
                )
            )
        ))
        (get-level-rec (get-elems-of-level lst 0) 0 0 0)
    )
)

(let ((lst '(A (B (D (H)) (E (I))) (C (F (J) (K)) (G (L))))))
    (format t "The level with the max number of elements is: ")
    (princ (get-level-with-max-elements lst))
    (fresh-line)
    (format t "The elements of the level with the max number of elements are: ")
    (princ (get-elems-of-level lst (get-level-with-max-elements lst)))
)