%option noyywrap
/* avoid dependency with library fl */

%{
#include "y.tab.h"
#include "Table_des_symboles.h"
#include <stdio.h>

%}

whitespace          [ \t\r\n\f]+

digit               [0-9]
alpha               [a-zA-Z]
alnum              [a-zA-Z0-9]

integer             [[:digit:]]+
float               [[:digit:]]+\.[[:digit:]]*
boolean             "true"|"false"

identifier          [[:alpha:]][[:alnum:]_]*

escape              \\([\\"'ntbr ])
string              \"({escape}|[^"\\])*\"


%%
"++"         {yylval = "++"; return CONCAT;}
"+"          {yylval = "+"; return PLUS;}
"-"          {yylval = "-"; return MOINS;}
"*"          {yylval = "*"; return MULT;}
"/"          {yylval = "/"; return DIV;}
"="          {yylval = "="; return EQ;}
"<"          {yylval = "<"; return ISLT;}
">"          {yylval = ">"; return ISGT;}
"<="         {yylval = "<="; return ISLEQ;}
">="         {yylval = ">="; return ISGEQ;}
"=="         {yylval = "=="; return ISEQ;}
"!"          {yylval = "!"; return NOT;}
"&&"         {yylval = "&&"; return AND;}
"||"         {yylval = "||"; return OR;}

"let"        {return LET;}
"in"         {return IN;}
"if"         {return IF;}
"then"       {return THEN;}
"else"       {return ELSE;}


{boolean}    {return BOOL;}

"("          {return LPAR;}
")"          {return RPAR;}
"["          {return LBR;}
"]"          {return RBR;}
","          {return VIR;}
";"          {return PV;}

{float}      {return FLOAT; }
{integer}    {yyval = atoi(yytext); return NUM; }
{identifier} {yyval = yytext; return ID;}
{string}     {return STRING;}
{whitespace} ;
