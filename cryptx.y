%{
void yyerror (char const *s);
int yylex();
#include <stdio.h>   
#include <time.h>  
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
//default symbols
int symbols[52];
char *strings[52];
int symbolVal(char symbol);
double runTime(void (*fx)(void));
void updateSymbolVal(char symbol, int val);
void updateStringsVal(char symbol, char *val);
int computeSymbolIndex(char token);
char *stringsVal(char symbol);
void encrypt_AES(char *str);
void decrypt_AES(char *str);
char *delete_first_last_char(char *str);
void pascal_triangle(int n);

//calculating functions
%}

%union {int number; char id; char *str;}
%start prog
%token EXIT PRINT HELP ENCRYPT DECRYPT eSHA256 dSHA256 STRING_VALUE BRACKET_O BRACKET_C BRACKET_SQ_O BRACKET_SQ_C BRACKET_C_O BRACKET_C_C
%token ADD SUB MUL DIV MOD ADD_SELF SUB_SELF MUL_SELF DIV_SELF MOD_SELF EQ NEQ LESS LESS_EQ BIG BIG_EQ AND OR FUNC NEWLINE WAVE
%token eAES dAES PASTRI
%token IF ELSE ELSEIF FOR WHILE
%token <id> IDENTIFIER
%token <str> STRING
%token <number> NUMBER
%type <id> assignment 
%type <number> exp term arithmetic_stmt wave_stmt
%type <str> STRING_term 
%token VARIABLE
%left '+' '-'
%left '*' '/' 
%%



prog: stmts
    ;

stmts: stmt stmts
     | stmt
     ;    

stmt: non_block_stmt
    | block_stmt
    ;

non_block_stmt: assignment  ';'      {;}
              | stmt_help
              | stmt_print
              | stmt_exit
              | stmt_encrypt
              | stmt_decrypt
              | arithmetic_stmt
              | call_func_stmt
              ;

block_stmt: if_stmt                  {}
          | for_stmt                 {}
          | while_stmt               {}
          | func_stmt                {}
          ;
    
block: BRACKET_C_O stmts BRACKET_C_C {;}
     ;  
      

if_stmt: IF BRACKET_O exp BRACKET_C block                                {if($3 == 1) {;} else {;} }
       | IF BRACKET_O exp BRACKET_C block ELSE block                     {if($3 == 1) {;} else {;} }
       | IF BRACKET_O exp BRACKET_C block elseif_stmt ELSE block         {if($3 == 1) {;} else {;} }
       ;

elseif_stmt: ELSEIF BRACKET_O exp BRACKET_C block                        {if($3 == 1) ; else ;}
           ;

for_stmt: FOR BRACKET_O term BRACKET_C BRACKET_C_O wave_stmt BRACKET_C_C {for(int i = 0; i < $3; i++) {printf("%d\n",$6);} }
        ;    

wave_stmt: WAVE term WAVE                                                {$$ = $2; }

while_stmt: WHILE BRACKET_O exp BRACKET_C block                          {;}
          ;

func_stmt: FUNC IDENTIFIER BRACKET_O params BRACKET_C block              {;}
         ;

call_func_stmt: IDENTIFIER BRACKET_O params BRACKET_C                    {;}
              ;

stmt_exit: EXIT                            {printf("See you next time\n"); exit(EXIT_SUCCESS);}
         ;
//print
stmt_print: PRINT STRING_term ';'          {printf("%s\n", delete_first_last_char($2));}
          | PRINT exp ';'                  {printf("%d\n", $2);}
          | PRINT NEWLINE ';'              {printf("\n");}
          ;
//help
stmt_help: HELP                            {printf("`--help -encrypt` -> list of encrypt algorithms\n`--help -decrypt` -> list of decrypt algorithms\n");} 
         | ENCRYPT                         {printf("encrypt algorithms\n `-eAES value` =>AES algorithm\n");}
         | DECRYPT                         {printf("decrypt algorithms\n `-dAES value` =>AES algorithm\n");}
         | PASTRI NUMBER                   {pascal_triangle($2);}
         ;
stmt_encrypt: eAES STRING                       {encrypt_AES(delete_first_last_char($2));}
            ; 

stmt_decrypt: dAES STRING                      {decrypt_AES(delete_first_last_char($2));}
            ;         
            
assignment : IDENTIFIER '=' exp            {updateSymbolVal($1,$3);}
           | IDENTIFIER '=' assignment     {;}
           | IDENTIFIER '=' STRING_term    {updateStringsVal($1,$3);}
           ;    

arithmetic_stmt : term                     {;} 
                | arithmetic_stmt ADD term {printf("%d\n", $1 + $3);}
                | arithmetic_stmt SUB term {printf("%d\n", $1 - $3);}
                | arithmetic_stmt MUL term {printf("%d\n", $1 * $3);}
                | arithmetic_stmt DIV term {printf("%d\n", $1 / $3);}
                ;

exp      : term                             {$$ = $1;}
         | exp ADD term                     {$$ = $1 + $3;}
         | exp SUB term                     {$$ = $1 - $3;}
         | exp MUL term                     {$$ = $1 * $3;}
         | exp DIV term                     {$$ = $1 / $3;}
         | exp MOD term                     {$$ = $1 % $3;} 
         | exp EQ term                      {$$ = $1 == $3;}
         | exp NEQ term                     {$$ = $1 != $3;}
         | exp LESS term                    {$$ = $1 < $3;}
         | exp LESS_EQ term                 {$$ = $1 <= $3;}
         | exp BIG term                     {$$ = $1 > $3;}
         | exp BIG_EQ term                  {$$ = $1 >= $3;}
         | exp AND term                     {$$ = $1 && $3;}
         | exp OR term                      {$$ = $1 || $3;}
         ;                

term     : NUMBER                           {$$ = $1;}
         | IDENTIFIER                       {$$ = symbolVal($1);}
         ;       

STRING_term  : STRING                       {$$ = $1;}
             | STRING_VALUE IDENTIFIER      {$$ = stringsVal($2);}
             ;
params   : param                      {;}
         | params ',' param            {;}
         ;
                    
param : IDENTIFIER ',' ','           
       
%%

void pascal_triangle(int n)
{
    int i, j, space, coef = 1;
 for (i = 0; i < n; i++) {
      for (space = 1; space <= n - i; space++)
         printf("  ");
      for (j = 0; j <= i; j++) {
         if (j == 0 || i == 0)
            coef = 1;
         else
            coef = coef * (i - j + 1) / j;
         printf("%4d", coef);
      }
      printf("\n");
   }
}


char *delete_first_last_char(char *str)
{
//if last char is ; delete it too
if(str[strlen(str)-1] == ';')
{
    str[strlen(str)-1] = '\0';
}

    int len = strlen(str);

    char *new_str = (char *)malloc(sizeof(char) * (len - 2));
    int i;
    for(i = 1; i < len - 1; i++)
    {
        new_str[i - 1] = str[i];
    }
    new_str[i - 1] = '\0';
    return new_str;
}

void encrypt_AES(char *str)
{
    int i;
    for(i = 0; i < strlen(str); i++)
    {
    printf("%c", str[i]+1);
    }   
        
    
}

void decrypt_AES(char *str)
{
    int i;
    for(i = 0; i < strlen(str); i++)
    {
            printf("%c", str[i]-1);

    }
}

int computeSymbolIndex(char token)
{
    int idx = -1;
    if(islower(token)){
        idx = token - 'a' + 26;
    }
    else if(isupper(token)){
        idx = token - 'A';
    }
    return idx;
}

int symbolVal(char symbol)
{
    int idx = computeSymbolIndex(symbol);
    if(idx == -1){
        printf("Symbol %c not found\n", symbol);
        exit(EXIT_FAILURE);
    }
    return symbols[idx];
}

char *stringsVal(char symbol)
{
    int idx = computeSymbolIndex(symbol);
    if(idx == -1){
        printf("Symbol %c not found\n", symbol);
        exit(EXIT_FAILURE);
    }
    printf("%s\n", strings[idx]);
    return strings[idx];
}


void updateSymbolVal(char symbol, int val)
{
    int idx = computeSymbolIndex(symbol);
    if(idx == -1){
        printf("Symbol %c not found\n", symbol);
        exit(EXIT_FAILURE);
    }
    symbols[idx] = val;
}
void updateStringsVal(char symbol, char *val)
{
    int idx = computeSymbolIndex(symbol);
    if(idx == -1){
        printf("Symbol %c not found\n", symbol);
        exit(EXIT_FAILURE);
    }
    strings[idx] = val;
}

int main(void){
    int i;
    for(i = 0; i < 52; i++){
        symbols[i] = 0;
        strings[i] = "";
    }
return yyparse();
}

void yyerror(char const *s)
{
    fprintf(stderr, "%s\n", s);
}