%{
#include <stdio.h>
#include "y.tab.h"
int lineCounter =1;
%}


int [-]?[1-9][0-9]*
name_var [a-z][a-zA-Z0-9_]*
new_line [\n]
string ["].*["]
char [a-zA-Z]


%%
"--exit"            return(EXIT);
"print"             return(PRINT);
"--help"            return(HELP);
"--help -encrypt"   return(ENCRYPT);
"--help -decrypt"   return(DECRYPT);
"-eAES"             return(eAES);
"-dAES"             return(dAES);
"-pascalTriangle"   return(PASTRI);
"~"                 return(WAVE);
"("                 return(BRACKET_O);
")"                 return(BRACKET_C);
"["                 return(BRACKET_SQ_O);
"]"                 return(BRACKET_SQ_C);
"{"                 return(BRACKET_C_O);
"}"                 return(BRACKET_C_C);
"+"                 return(ADD); 
"-"                 return(SUB);
"*"                 return(MUL);;
"/"                 return(DIV);
"%"                 return(MOD);
"+="                return(ADD_SELF);
"-="                return(SUB_SELF);
"*="                return(MUL_SELF);
"/="                return(DIV_SELF);
"%="                return(MOD_SELF);
"=="                return(EQ);
"!="                return(NEQ);
"<"                 return(LESS);
"<="                return(LESS_EQ);
">"                 return(BIG);
">="                return(BIG_EQ);
"&&"                return(AND);
"||"                return(OR);
"/n"                return(NEWLINE);
"if"                return(IF);
"else"              return(ELSE);
"else if"           return(ELSEIF);
"for"               return(FOR);
"while"             return(WHILE); 
"function"          return(FUNC);  
{name_var}          {yylval.id = yytext[0]; return IDENTIFIER;}
{int}               {yylval.number = atoi(yytext); return NUMBER;}
{string}            {yylval.str = yytext; return STRING;}
"%s"                return(STRING_VALUE);
{new_line}          {lineCounter++;}
[ \t\r]             ;
[-+=;]              return yytext[0];
.                   printf(" ");  
%%
int yywrap(void) {
    return 1;
}