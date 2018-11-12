/*
 *  Attribut.h
 *
 *  Module for handling attributes
 *
 */

#ifndef ATTRIBUT_H
#define ATTRIBUT_H
#include <stdbool.h>

typedef enum {Int, Float} symb_type ;

typedef struct{
int value;
bool boule;
symb_type type;
} symb_value_type;

char* getType(symb_type);

int comp(int g, int d, int op);

int branch(int b, int t, int e);



#endif
