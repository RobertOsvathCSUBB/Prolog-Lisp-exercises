; a.
; remove-nth(l1l2...ln, n, count) = nil, if lst = nil
;                        = remove-nth(l2l3...ln, n, 1), if count = n
;                        = l1 U remove-nth(l2l3...ln, n, count+1), otherwise
; eliminate-every-nth-element(lst, n) = remove-nth(lst, n, 1)
(
    defun eliminate-every-nth-element (lst n)
    (labels ((remove-nth (lst n count)
                (cond
                    ((null lst) nil)
                    ((= count n) (remove-nth (cdr lst) n 1))
                    (t (cons (car lst) (remove-nth (cdr lst) n (+ count 1))))
                )
            ))
            (remove-nth lst n 1)
    )
)

(let ((my_list '(10 8 6 17 19 20)))
    (format t "The list (10 8 6 17 19 20) after eliminating every 3rd element: ")
    (princ (eliminate-every-nth-element my_list 3))
    (fresh-line)
)

; b.
; check-valley(l1l2..ln, dir) = true, if there is a single element in the list
;                             = check-valley(l2l3..ln, 0), if dir = 0 and l1 >= l2 (the subsequence is decreasing)
;                             = check-valley(l2l3..ln, 1), if dir = 0 and l1 < l2 (the direction switched, the subsequence is increasing)
;                             = check-valley(l2l3..ln, 1), if dir = 1 and l1 <= l2 (the direction was already changed, the subsequence became increasing)
;                             = false, otherwise
; check-valley-aspect(l1l2...ln) = false, if the list has less than 3 elements, or it's increasing from the beginning
;                                = check-valley(l1l2...ln, 0), otherwise 
(
    defun check-valley-aspect (lst)
    (labels (
        (check-valley (lst dir)
            (cond
                ((null (cdr lst)) t)
                ((and (eq dir 0) (>= (car lst) (cadr lst))) (check-valley (cdr lst) 0))
                ((and (eq dir 0) (< (car lst) (cadr lst))) (check-valley (cdr lst) 1))
                ((and (eq dir 1) (<= (car lst) (cadr lst))) (check-valley (cdr lst) 1))
                (t nil)
            )
        ))
        (if (null lst) 
            nil
            (if (null (cdr lst))
                nil
                (if (null (cddr lst))
                    nil
                    (if (<= (car lst) (cadr lst))
                        nil
                        (check-valley lst 0)
                    )
                )
            )
        )
    )
)

(let ((my_list '(10 8 6 17 19 20)))
    (format t "The list (10 8 6 17 19 20) has a valley aspect: ")
    (princ (check-valley-aspect my_list))
    (fresh-line)
)

; my append function
(
    defun my-append (lst1 lst2)
    (cond
        ((null lst1) lst2)
        ((null lst2) lst1)
        (t (cons (car lst1) (my-append (cdr lst1) lst2)))
    )
)

; c.
; get-min-rec(l1l2...ln, min) = min, if lst = nil
;                             = get-min-rec(l1 U l2l3...ln, min), if l1 is a list
;                             = get-min-rec(l2l3...ln, l1), if l1 < min
;                             = get-min-rec(l2l3...ln, min), otherwise
; get-min(l1l2...ln) = get-min-rec(lst, l1)
(
    defun get-min (lst)
    (labels (
        (get-min-rec (lst min)
            (cond
                ((null lst) min)
                ((listp (car lst)) (get-min-rec (my-append (car lst) (cdr lst)) min))
                ((< (car lst) min) (get-min-rec (cdr lst) (car lst)))
                (t (get-min-rec (cdr lst) min))
            )
        ))
        (get-min-rec lst (car lst))
    )
)

(let ((my_list '(10 8 6 (1 2 1) 17 19 20)))
    (format t "The minimum element of the list (10 8 6 (1 2 1) 17 19 20): ")
    (princ (get-min my_list))
    (fresh-line)
)

; d.
; get-max-rec(l1l2...ln, max) = max, if lst = nil
;                             = get-max-rec(l1 U l2l3...ln, max), if l1 is a list
;                             = get-max-rec(l2l3...ln, l1), if l1 > max
;                             = get-max-rec(l2l3...ln, max), otherwise
; get-max(l1l2...ln) = get-max-rec(lst, l1)
(
    defun get-max (lst)
    (labels (
        (get-max-rec (lst max)
            (cond
                ((null lst) max)
                ((listp (car lst)) (get-max-rec (my_append (car lst) (cdr lst)) max))
                ((> (car lst) max) (get-max-rec (cdr lst) (car lst)))
                (t (get-max-rec (cdr lst) max))
            )
        ))
        (get-max-rec lst (car lst))
    )
)

; delete-max-rec(l1l2...ln, max) = nil, if lst = nil
;                                = delete-max-rec(l2l3...ln, max), if l1 = max
;                                = l1 U delete-max-rec(l2l3...ln, max), otherwise
; delete-max(l1l2...ln) = delete-max-rec(l1l2...ln, get-max(l1l2...ln))
(
    defun delete-max (lst)
    (labels (
        (delete-max-rec (lst max)
            (cond
                ((null lst) nil)
                ((= (car lst) max) (delete-max-rec (cdr lst) max))
                (t (cons (car lst) (delete-max-rec (cdr lst) max)))
            )
        ))
        (let ((max (get-max lst)))
            (delete-max-rec lst max)
        )
    )
)

(let ((my_list '(20 10 8 20 6 17 19 20)))
    (format t "The list (20 10 8 20 6 17 19 20) after deleting the maximum element: ")
    (princ (delete-max my_list))
    (fresh-line)
)
