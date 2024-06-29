Red [
	Title: "redcalc"
	Version: 0.1
	Author: "Will B."
]

; Includes
do %parse.red
do %eval.red

; Main evaluation loop
forever [
	input-str: ask ">>> "

	if input-str == "q" [ ; Interestingly "ask" seems to convert EOF (Ctrl+D) into "q"
		break
	]

	valid: parse input-str [
		calculation
	]

	unless valid [
		print "Syntax Error: Please refer to documentation or parse grammar for syntax"
		continue
	]

	result: catch [ eval-expr scope ]
	either (type? result) == string! [
		print result
	] [
		prin "= "
		probe result
	]
]
