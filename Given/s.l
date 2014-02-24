(
defun double-recursive(y)
	(cond
		((null y)nil)
		((numberp (car y)) (cons (append '((car y)) '((car y))) (double-recursive (cdr y))))
		((atom (car y)) (double-recursive (cdr y)))
		(t (cons (append '((car y)) '((car y))) (double-recursive(cdr y))))
	)
)