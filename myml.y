
%code requires {


#include "Table_des_symboles.h"  // header included in y.tab.h

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
  symb_value_type val;
  char * sid;
}



%type <val> atom_exp
%type <val> arith_exp
%type <val> let_exp
%type <val> bool
%type <val> comp
%type <val> control_exp



%token NUM
%type <val> NUM
%token <val> FLOAT
%token ID
%type <sid> ID
%token STRING

%token PV LPAR RPAR LBR RBR LET IN VIR

%token IF THEN ELSE

%token ISLT ISGT ISLEQ ISGEQ ISEQ
%left ISEQ
%left ISLT ISGT ISLEQ ISGEQ


%token AND OR NOT BOOL
%left OR
%left AND

%type <val> exp

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

inst : aff
| exp
;


aff : aff_id
| aff_fun
;

aff_id : ID EQ exp  { set_symbol_value($1,$3); printf("%s de type <%s> vaut %d\n", $1,getType($3.type),$3.value);}
;

aff_fun : fun_head EQ exp
;

fun_head : ID id_list
;

id_list : ID
| id_list ID
;


exp : arith_exp
| atom_exp {$$ = $1;}/*{printf("%d\n", $1.value);} Il faudra faire un switch pour l'affichage*/
| control_exp
| let_exp
| LPAR funcall_exp RPAR
;

arith_exp : MOINS exp %prec UNA
| exp PLUS exp {
                $$.type = Int;
                $$.value = $1.value + $3.value;
                printf("<exp> de type <%s> vaut %d\n", getType($$.type), $$.value);
                }
| exp MULT exp
| exp CONCAT exp
;

atom_exp : NUM {$$.value = $1.value;}
| FLOAT
| STRING
| ID {$$ = get_symbol_value($1);}
| list_exp
| LPAR exp RPAR {$$ = $2;}
;

control_exp : IF bool THEN atom_exp ELSE atom_exp {
  $$.value = $2.value;
  printf("moi c bool %d\n", $2.value);
  if ($$.value == true)
    $$ = $4;
  else
    $$ = $6;
}
;

let_exp : let2 aff IN atom_exp {$$ = $4;lessStorage();}
;

let2 : LET {moreStorage();}

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
| exp comp exp {$$.value = comp($1.value,$3.value,$2.value);
  printf("moi c valueaser %d\n", $$.value);
}

| LPAR bool RPAR
;


comp : ISLT  {$$.value=0;}
| ISGT {$$.value=1;}
| ISLEQ {$$.value=2;}
| ISGEQ {$$.value=3;}
| ISEQ {$$.value=4;}
;

%%
int main () {
 return yyparse ();
}
