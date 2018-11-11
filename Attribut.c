/*
 *  Attribut.c
 *
 */

#include "Attribut.h"





char* getType(symb_type t)
{
  switch (t) {
    case 0: return "int";
    case 1: return "float";
  }
}

/* HERE COMES YOUR CODE */
