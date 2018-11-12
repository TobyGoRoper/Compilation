/*
 *  Attribut.c
 *
 */

#include "Attribut.h"
#include <stdio.h>
#define MAX 10




char* getType(symb_type t)
{
  switch (t) {
    case 0: return "int";
    case 1: return "float";
  }
}


// return a bool for a comparaison
int comp(int g, int d, int op)
{
  bool a=false;
  switch(op)
  {
    case 0: //LT
      a = (g < d);
      break;
    case 1://GT
      a =  (g > d);
      break;
    case 2: //LEQ
      a =  (g <= d);
      break;
    case 3: //GEQ
      a =  (g >= d);
      break;
    case 4: // EQ
      a =  (g == d);
      break;
  }
  printf("je me barre c nul ici %d %d\n", op, a );
  return a;
}

int branch(int b, int t, int e)
{
printf("eh je me branche avec b = %d \n", b );
  if (b==0)
  {
    printf("je retourne e = %d\n",e );
    return e;
  }
  printf("je retourne t = %d\n", t);
  return t;
}
