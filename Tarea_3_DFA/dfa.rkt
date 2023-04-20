#|

Validate the components of a string

3/17/2023
Mario Ignacio Frias Pina
Alan Anthony Hernadez Perez
|#

#lang racket

(require racket/trace)

(provide arithmetic-lexer)

;Creates a structure with the 5 values in a DFA machine
(struct dfa (func init final))

;Function that is called by the user that needs only the string
(define (arithmetic-lexer str)
	(validate-dfa str (dfa delta-dfa 'start '(comment int float exp op var simb spa spa_op par_close))))

;Function that evaluates if a string is valid for a DFA
(define (validate-dfa str machine)
	(let loop
	 ([str (string->list str)]
	  [state (dfa-init machine)]
	  ;List of all found tokens
	  [lst '()]
	  ;Current token
	  [curr '()])
	 (cond 
	  ;If it is the end of the string
	  [(empty? str)
	  	;If it is a valid ending state
	  	(if (member state (dfa-final machine))
		 	;If the current token is an empty string, so that it either adds it to list or not
		 	(if (empty? curr)
				(reverse lst)
				(reverse (cons (list (list->string (reverse curr)) state) lst)))
			#f)]
	  ;If it is not the end of the string
	  [else
	  	;Divides the tuple that the machine gives into 2 different 'variables'
	  	(let-values
		          ;   var1      var2   Call to the transition function
		 ([(new-state found) ((dfa-func machine) state (car str))])
	  	 (loop
		  	;Goes to the next character of the string
		  	(cdr str)
			;Goes to the new state returned by the machine
		  	new-state
			;If the state recieved is a valid one, add it to the list
		 	(if found
		  		(cons (list (list->string (reverse curr)) found) lst)
				lst)
			;If the state recieved is a valid one, clear the current token value
 			(if found
				(if (or (eq? new-state 'comment) (not (char-whitespace? (car str))))
		  			(cons (car str) '())
					'())
				(if (or (eq? new-state 'comment) (not (char-whitespace? (car str))))
		  			(cons (car str) curr)
					curr))
		 ))])))

;Function that returns if a character is an operator, except for /
(define (char-operator? char)
	(member char (string->list "^+=-*%")))

; Accept expressions of different types
; Start state: 'start
; Accept states: '(comment int float exp op var simb spa spa_op par_close)
(define (delta-dfa state char)
   (cond
	    [(eq? state 'start) (cond
			[(eq? char #\() (values 'par_open #f)]
			[(char-numeric? char) (values 'int #f)]
			[(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
			[(or (char-alphabetic? char) (eq? char #\_)) (values 'var #f)]
			[(eq? char #\/) (values 'first #f)]
			[(char-whitespace? char) (values 'start #f)]
			[else (values 'inv #f)])]
		[(eq? state 'first) (cond
			[(eq? char #\/) (values 'comment #f)]
			[else (values 'inv #f)])]
		[(eq? state 'div) (cond
			[(eq? char #\/) (values 'comment #f)]
			[(eq? char #\() (values 'par_open 'op)]
			[(char-numeric? char) (values 'int 'op)]
			[(or (eq? char #\+) (eq? char #\-)) (values 'sign 'op)]
			[(char-alphabetic? char) (values 'var 'op)]
			[(char-whitespace? char) (values 'spa_op 'op)]
			[else (values 'inv #f)])]
		[(eq? state 'comment) (cond
			[(eq? char "\n") (values 'start 'comment)]
			[else (values 'comment #f)])]
		[(eq? state 'sign) (cond
			[(char-numeric? char) (values 'int #f)]
			[else (values 'inv #f)])]
		[(eq? state 'int) (cond
			[(char-numeric? char) (values 'int #f)]
			[(eq? char #\.) (values 'dot #f)]
			[(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
			[(char-whitespace? char) (values 'spa 'int)]
			[(eq? char #\)) (values 'par_close 'int)]
			[(eq? char #\/) (values 'div 'int)]
			[(char-operator? char) (values 'op 'int)]
			[else (values 'inv #f)])]
		[(eq? state 'dot) (cond
			[(char-numeric? char) (values 'float #f)]
			[else (values 'inv #f)])]
		[(eq? state 'float) (cond
			[(char-numeric? char) (values 'float #f)]
			[(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
			[(char-whitespace? char) (values 'spa 'float)]
			[(eq? char #\)) (values 'par_close 'float)]
			[(eq? char #\/) (values 'div 'float)]
			[(char-operator? char) (values 'op 'float)]
			[else (values 'inv #f)])]
		[(eq? state 'e) (cond
			[(char-numeric? char) (values 'exp #f)]
			[(or (eq? char #\+) (eq? char #\-)) (values 'signe #f)]
			[else (values 'inv #f)])]
		[(eq? state 'signe) (cond
			[(char-numeric? char) (values 'exp #f)]
			[else (values 'inv #f)])]
		[(eq? state 'exp) (cond
			[(char-numeric? char) (values 'exp #f)]
			[(eq? char #\/) (values 'div 'exp)]
			[(eq? char #\)) (values 'par_close 'exp)]
			[(char-operator? char) (values 'op 'exp)]
			[(char-whitespace? char) (values 'spa 'exp)]
			[else (values 'inv #f)])]
		[(eq? state 'var) (cond
			[(or (char-numeric? char) (eq? char #\_) (char-alphabetic? char)) (values 'var #f)]
			[(char-whitespace? char) (values 'spa 'var)]
			[(eq? char #\/) (values 'div 'var)]
			[(eq? char #\)) (values 'par_close 'var)]
			[(char-operator? char) (values 'op 'var)]
			[else (values 'inv #f)])]
		[(eq? state 'op) (cond
			[(eq? char #\() (values 'par_open 'op)]
			[(char-numeric? char) (values 'int 'op)]
			[(or (eq? char #\+) (eq? char #\-)) (values 'sign 'op)]
			[(char-alphabetic? char) (values 'var 'op)]
			[(char-whitespace? char) (values 'spa_op 'op)]
			[else (values 'inv #f)])]
		[(eq? state 'spa) (cond
			[(eq? char #\/) (values 'div #f)]
			[(char-operator? char) (values 'op #f)]
			[(char-whitespace? char) (values 'spa #f)]
			[(eq? char #\)) (values 'par_close #f)]
			[else (values 'inv #f)])]
		[(eq? state 'spa_op) (cond
			[(eq? char #\() (values 'par_open #f)]
			[(eq? char #\)) (values 'par_close #f)]
			[(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
			[(or (char-alphabetic? char) (eq? char #\_)) (values 'var #f)]
			[(char-numeric? char) (values 'int #f)]
			[(char-whitespace? char) (values 'spa_op #f)]
			[else (values 'inv #f)])]
		[(eq? state 'par_open) (cond
			[(or (char-alphabetic? char) (eq? char #\_)) (values 'var 'par_open)]
			[(eq? char #\)) (values 'par_close 'par_open)]
			[(or (eq? char #\+) (eq? char #\-)) (values 'sign 'par_open)]
			[(char-numeric? char) (values 'int 'par_open)]
			[(char-whitespace? char) (values 'spa_op 'par_open)]
			[else (values 'inv #f)])]
		[(eq? state 'par_close) (cond
			[(eq? char #\/) (values 'div 'par_close)]
			[(char-operator? char) (values 'op 'par_close)]
			[(char-whitespace? char) (values 'spa 'par_close)]
			[else (values 'inv #f)])]
		[else (values 'inv #f)]
		))
;(trace delta-dfa)
