/*
 *  Attribut.h
 *
 *  Module for handling attributes
 *
 */

#ifndef ATTRIBUT_H
#define ATTRIBUT_H

typedef enum {Int, Float} symb_type ;

typedef struct{
int value;
symb_type type;
} symb_value_type;

char* getType(symb_type);




#endif
