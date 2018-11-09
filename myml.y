
%code requires {


#include "Attribut.h"  // header included in y.tab.h

}

%{
#include <stdio.h>


extern int yylex();
extern int yyparse();

void yyerror (char* s) {
   printf("\n%s\n",s);
 }

%}

%union{
  symb_val_type val;
  car * sid; 
}


%token NUM FLOAT ID STRING

%token PV LPAR RPAR LBR RBR LET IN VIR

%token IF THEN ELSE

%token ISLT ISGT ISLEQ ISGEQ ISEQ
%left ISEQ
%left ISLT ISGT ISLEQ ISGEQ


%token AND OR NOT BOOL
%left OR
%left AND



%token PLUS MOINS MULT DIV EQ
%left PLUS
%left MULT
%left CONCAT
%nonassoc UNA    /* pseudo token pour assurer une priorite locale */


%start prog



%%

prog : inst PV
| prog inst PV
;

inst : aff {$$ = $1}
| exp
;


aff : aff_id {$$ = $1}
| aff_fun
;

aff_id : ID EQ exp  { set_symbol_value($1,$3); printf("%s de type <> vaut %d", $1,$3);}
;

aff_fun : fun_head EQ exp
;

fun_head : ID id_list
;

id_list : ID
| id_list ID
;


exp : arith_exp
| atom_exp {$$ = $1}
| control_exp
| let_exp
| LPAR funcall_exp RPAR
;

arith_exp : MOINS exp %prec UNA
| exp PLUS exp
| exp MULT exp
| exp CONCAT exp
;

atom_exp : NUM {$$ = $1}
| FLOAT {$$ = $1}
| STRING {$$ = $1}
| ID {$$ = $1}
| list_exp {$$ = $1}
| LPAR exp RPAR {$$ = $1}
;

control_exp : IF bool THEN atom_exp ELSE atom_exp
;

let_exp : LET aff IN atom_exp
;

funcall_exp : ID atom_list
;

atom_list : atom_exp
| atom_list atom_exp
;


list_exp : LBR exp_list RBR
;

exp_list : exp
| exp_list VIR exp
;

bool : BOOL
| bool OR bool
| bool AND bool
| NOT bool %prec UNA
| exp comp exp
| LPAR bool RPAR
;


comp :  ISLT | ISGT | ISLEQ | ISGEQ | ISEQ
;

%%
int main () {
 return yyparse ();
}
