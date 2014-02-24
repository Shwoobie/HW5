(
defun double-recursive(y)
	(cond
		((null y)nil)
		((numberp (car y)) (append (cons (car y) (car y)) (double-recursive (cdr y))))
		((atom (car y)) (double-recursive (cdr y)))
		(t (append (cons (car y) (car y)) (double-recursive(cdr y))))
	)
)