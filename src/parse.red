Red [
]

ws: charset reduce [space tab cr lf]
wo: [ any ws ]
digit: charset "0123456789"
literal: [ some digit opt [ "." some digit ] opt [ [ "e" | "E" ] some digit ] ]
alph: charset [#"a" - #"z" #"A" - #"Z"]
fn-ident: [ some [ alph | "_" ] ]
; infix-ops: charset "-+/*^^"
postfix-ops: charset "!"
prefix-ops: charset "-"
; expr: [ collect [ opt [ keep prefix-ops ] wo [ keep literal | "(" expr ")" | expr ] opt [ keep postfix-ops ] wo opt [ keep infix-ops wo expr ] wo opt [ keep postfix-ops ] ] ]

infix-ops-1: charset "^^"
infix-ops-2: charset "/*"
infix-ops-3: charset "-+"

; args: [ expr any [ "," expr ] ]

z: [ keep literal | "(" wo expr wo ")" | collect [ keep fn-ident "(" wo expr wo ")" ] ]
y: [ opt [ keep prefix-ops ] z opt [ keep postfix-ops ] ]
x: [ collect y wo opt [ keep infix-ops-1 wo x ] ]
w: [ collect x wo opt [ keep infix-ops-2 wo w ] ]
v: [ collect w wo opt [ keep infix-ops-3 wo v ] ]
expr: [ collect v ]
calculation: [ collect set scope [ expr ] ]