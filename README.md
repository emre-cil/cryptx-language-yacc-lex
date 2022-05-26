# Programming Language CryptX

\<developer\> : Emre Çil

> CryptX Programming language basically helps to do encryption and decryption and some fun :) .

### Commands to run
```
> make cryptx
> make run
> make clear
```
## Syntax

```
<prog> : <stmts> EXIT

<stmts> : <stms> <stmt> | <stmt>

<stmt> : <block_stmt> | <n_block_stmt> 

<block_stmt> :  <if_stmt> | <for_stmt> | <while_stmt> | <func_stmt>

<n_block_stmt> : assignment | stmt_help | stmt_print | stmt_exit | stmt_encrypt | stmt_decrypt | arithmetic_stmt | call_func_stmt


<func_param_type> : <type> NAME_VAR | <func_param_type> NAME_VAR COMMA <type> NAME_VAR

<assignment> : IDENTIFIER EQUAL exp | IDENTIFIER EQUAL assignment | IDENTIFIER EQUAL STRING_term

<exp> : term | exp ADD term | exp SUB term | exp MUL term | exp DIV term | exp MOD term | exp EQ term | exp NEQ term | exp LESS term | exp LESS_EQ term | exp BIG term | exp LESS_EQ term | exp BIG_EQ term | exp AND term | exp OR term 

<term> : NUMBER | IDENTIFIER

<STRING_term> : STRING | STRING_VALUE IDENTIFIER

<param> : IDENTIFIER VAR

<params> : <param> | <params> COMMA <param>

<def_var> : <IDENTIFIER> NAME_VAR

<stmt_print> : PRINT STRING_term SEMICOLON | PRINT exp SEMICOLON | PRINT NEWLINE SEMICOLON

<conditions> : OR | AND | EQ | NEQ

<condition_exp> : BOOL | <var> <conditions> <var>

<if_stmt> : <single_if_stmt> | <multi_if_stmt>

<single_if_stmt> : IF <condition_exp> <body>

<else_if_stmt> : ELSEIF <condition_exp> <body> | ELSEIF <condition_exp> <body> ELSEIF <condition_exp> <body>

<else_stmt> : ELSE <condition_exp> <body>

<multi_if_stm> : <single_if_stmt> <else_if_stmt> | <single_if_stmt> <else_if_stmt> <else_stmt>

<for_stmt> : FOR BRACKET_O <asssign> SCOLON <condition_exp> SCOLON <assigin> BRACKET_C <body>

<while_stmt> : WHILE BRACKET_O <condition_exp> BRACKET_C <body>

<func_stmt> : FUNC NAME_FUNC BRACKET_O <func_param_type> BRACKET_C <body>

<stmt_help> : HELP | ENCRYPT | DECRYPT | PASTRI NUMBER




```

## Explanations about the language and syntax

This language is basically designed to use encrypt and decrypt algorithms quickly, besides some fun features have been added and basic features in most languages have also been added. Coming to the Syntax part, there is no need for parentheses for print statements or plain operations, it offers simplicity by directly typing the operation on the screen without typing print. Also, I have no doubt that this language will form the foundations of the future web 3.0 which is open to development .D

