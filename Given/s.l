(
defun double-recursive(y)
	(cond
		((not(listp y)) nil)
		((null y)nil)
		((numberp (car y)) (append (list (car y) (car y)) (double-recursive (cdr y))))
		((atom (car y)) (double-recursive (cdr y)))
		(t (append (list (car y) (car y)) (double-recursive(cdr y))))
	)
)