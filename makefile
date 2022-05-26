cryptx : cryptx.l cryptx.y
		yacc -d cryptx.y
		lex cryptx.l
		gcc -o cryptx lex.yy.c y.tab.c -ll

run :  cryptx
			./cryptx < exampleprog1.cryptx

clear :
			rm -f y.tab.c y.tab.h lex.yy.c cryptx
