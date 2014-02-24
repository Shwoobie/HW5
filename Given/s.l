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

(
defun double-iterative(y) 
	(cond
		((not(listp y)) nil)
		((null y)nil)
		(t (let (temp))
				(do
					((l nil (append (list (car y) (car y)))))
					((null y) temp)
					(cond 
						((numberp (car y)); for number in list
							(cond
								((null l) (setq temp (append (list (car y) (car y)))
									(setq y (cdr y))))
								(t (setq temp l) (setq y (cdr y)))
							)
						)

						((atom (car y)) (setq y (cdr y)) ) ; for symbol in list

						(t ;for list in list 
							(cond
								((null l) (setq temp (append (list (car y) (car y)))
									(setq y (cdr y))))
								(t (setq temp l) (setq y (cdr y)))
							)
						)
					)
				)
				

			
		)
	)
)