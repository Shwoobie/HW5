(
defun double-recursive(y)
	(cond
		((not(listp y)) nil)
		((null y)nil)
		((null (car y)) (append(list (car y ) (car y)) (double-recursive(cdr y))))
		((numberp (car y)) (append (list (car y) (car y)) (double-recursive (cdr y))))
		((atom (car y)) (double-recursive (cdr y)))
		(t (append (list (car y) (car y)) (double-recursive(cdr y))))
	)
)

(defun double-iterative(y) 
	(cond
		((not(listp y)) nil)
		((null y)nil)
		(t (let (temp))
			(do
				((l nil (append (list (car y) (car y)))))
				((null y) temp)
				(cond 
					((null (car y)); for nil in list
						(cond
							((null l) (setq temp (append (list (car y) (car y))))
								(setq y (cdr y)))
							(t (setq temp (append temp l)) (setq y (cdr y)))
						)
					)
					((numberp (car y)); for number in list
						(cond
							((null l) (setq temp (append (list (car y) (car y))))
								(setq y (cdr y)))
							(t (setq temp (append temp l)) (setq y (cdr y)))
						)
					)

					((atom (car y)) (setq y (cdr y)) ) ; for symbol in list

					(t ;for list in list 
						(cond
							((null l) (setq temp (append (list (car y) (car y))))
								(setq y (cdr y)))
							(t (setq temp (append temp l)) (setq y (cdr y)))
						)
					)
				)
			)
		)
	)
)

(defun double-mapcar(y)
	(cond
		((not(listp y)) nil)
		((null y)nil)

		((numberp (car y))
			(apply 'append (apply 'mapcar (cons 'list (list y y))))

		)
		((atom (car y)) nil)
		(t 
			(apply 'append (apply 'mapcar (cons 'list (list y y))))
		)

		;((numberp (car y)) (append (list (car y) (car y)) (double-recursive (cdr y))))
		;((atom (car y)) (double-recursive (cdr y)))
		;(t (append (list (car y) (car y)) (double-recursive(cdr y))))
	)

)

(defun rdouble(y)
	(cond
		((not(listp y)) nil)
		((null y)nil)
		((null (car y)) (append(list (car y)) (rdouble(cdr y))))
		((numberp (car y)) (append (list (car y) (car y)) (rdouble (cdr y))))
		((atom (car y)) (rdouble(cdr y)))
		(t (cons (rdouble(car y)) (rdouble(cdr y))))
	)
)

(defun my-mapcar(fun l1 l2)
	(cond
		((or (null l1) (null l2)) nil)
		(t 
			(append (list (funcall fun (car l1) ( car l2))) (my-mapcar fun (cdr l1) (cdr l2)))
		) 
	)
	
)

(defun rewrite(x)
	(cond
		((null x)nil)
		((numberp x)  x)
		((atom x) x)
		((symbolp (car x)) ;if it's a symbol 
			(cond
				((equal (car x) 'if)
					(cond
						((or (numberp (cadr x)) (null (cadr x))) (cons 'cond (append(list (append(list (cadr x) (rewrite(caddr x)))))
							(cond
								((null (cdddr x))nil)
								(t (list(cons 't (list(rewrite(cadddr x))))))
							))))
						((listp (cdr x)) (cons 'cond (append(list (list(rewrite (cadr x)) (rewrite (caddr x))))
							(cond
								((null (cdddr x))nil)
								(t (list(cons 't (list(rewrite(cadddr x))))))
							)))
						)

					)
				)
				(t 
					(cond
						((equal 'cons (car x)) 
							(append (list(car x))  (list(rewrite (cadr x))) (list(rewrite (cddr x))))
						)
						((and (equal 'list (car x)) (listp (cadr x))) 
							(append (list(car x))  (list(rewrite (cadr x))) (list(rewrite (cddr x)))) 
						)
						(t (append(list (car x)) (rewrite (cdr x))))
					)
				 
				);if words/symbols

			)
		)
		((numberp (car x)) 
			(cond
				((or (numberp (cadr x)) (null (cadr x))) (append (list(car x)) (rewrite (cdr x))));if cdr is a number do this
				((listp (cadr x)) (append (list(car x))  (list(rewrite (cadr x))) (rewrite (cddr x)))
				)
			)

		)
		((listp (car x)) (append(rewrite(car x)) (rewrite(cdr x)))) ;if cdr is a list
	)
)

(defun check(x)
	(list(equal (eval x) (eval (rewrite x))) (eval x) (eval (rewrite x)))

)