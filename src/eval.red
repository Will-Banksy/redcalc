Red [
]

unwrap: func [e] [
	while [ ((type? e) == block!) ] [
		unless ((type? e/1) == block!) and ((length? e) == 1) [
			break
		]
		e: e/1
	]
	return e
]
factorial: func [n] [
	res: n
	i: n - 1
	while [ i > 0 ] [
		res: res * i
		i: i - 1
	]
	return res
]

eval-func: func [fn-ident arg] [
	switch/default fn-ident [
		"sin" [ return sin arg ]
		"cos" [ return cos arg ]
		"tan" [ return tan arg ]
		"abs" [ return absolute arg ]
		; TODO: Complete set of mathematical functions
	] [
		throw append append "Eval Error: Function " fn-ident " does not exist"
	]
]
eval-infix-op: func [op arg1 arg2] [
	return switch op [
		#"+" [ arg1 + arg2 ]
		#"-" [ arg1 - arg2 ]
		#"/" [ arg1 / arg2 ]
		#"*" [ arg1 * arg2 ]
		#"%" [ arg1 % arg2 ]
		#"^^" [ arg1 ** arg2 ]
	]
]
eval-prefix-op: func [op arg] [
	return switch op [
		#"-" [ 0 - arg ]
	]
]
eval-postfix-op: func [arg op] [
	return switch op [
		#"!" [ factorial arg ]
	]
]
eval-literal: func [e] [
	if ((type? e) == block!) [
		cause-error 'internal 'type [ "unhandled type" ]
	]
	return to-float to-string e
]
eval-z: func [e] [
	e: unwrap e
	; prin "eval-z: " probe e

	e_type: type? e
	case [
		(e_type == string!) or (e_type == char!) [ ; Numbers are stored as strings ...or characters for some reason
			return eval-literal e
		]
		e_type == block! [ ; e/1 Could be either an ident or number
			either error? result: try [ eval-literal e/1 ] [
				ident: e/1
				arg: eval-expr e/2
				return eval-func ident arg
			] [
				return result
			]
		]
	]
	cause-error 'internal 'type [ "unhandled type" ]
]
eval-y: func [e] [
	e: unwrap e
	; prin "eval-y: " probe e
	if (type? e) == block! [
		if (e/1 == #"-") and (e/3 == #"!") [
			return eval-prefix-op e/1 eval-postfix-op eval-expr e/2 e/3
		]
		if e/1 == #"-" [
			return eval-prefix-op e/1 eval-expr e/2
		]
		if e/2 == #"!" [
			return eval-postfix-op eval-expr e/1 e/2
		]
	]
	return eval-z e
]
eval-x: func [e] [
	e: unwrap e
	; prin "eval-x: " probe e
	if (type? e) == block! [
		if (e/2 == #"+") or (e/2 == #"-") [
			return eval-infix-op e/2 eval-expr e/1 eval-expr at e 3
		]
	]
	return eval-y e
]
eval-w: func [e] [
	e: unwrap e
	; prin "eval-w: " probe e
	if (type? e) == block! [
		if (e/2 == #"/") or (e/2 == #"*") or (e/2 == #"%") [
			return eval-infix-op e/2 eval-expr e/1 eval-expr at e 3
		]
	]
	return eval-x e
]
eval-v: func [e] [
	e: unwrap e
	; prin "eval-v: " probe e
	if (type? e) == block! [
		if e/2 == #"^^" [
			return eval-infix-op e/2 eval-expr e/1 eval-expr at e 3
		]
	]
	return eval-w e
]
eval-expr: func [e] [
	e: unwrap e
	; prin "eval-expr: " probe e
	return eval-v e
]