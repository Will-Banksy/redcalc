Red [
	Title: "redcalc"
	Version: 0.1
	Author: "Will Banks"
]

; Includes
do %parse.red
do %eval.red

; Main evaluation loop
forever [
	input-str: ask ">>> "
	print input-str

	if input-str == "q" [ ; Interestingly "ask" seems to convert EOF (Ctrl+D) into "q"
		break
	]

	scope: parse input-str [
		expr
	]

	probe scope

	result: eval-expr scope
	prin "= "
	probe result
]
