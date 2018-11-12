/*
 *  Table des symboles.c
 *
 *  Created by Janin on 12/10/10.
 *  Copyright 2010 LaBRI. All rights reserved.
 *
 */

#include "Table_des_symboles.h"

#include <stdlib.h>
#include <stdio.h>


/* The storage structure is implemented as a linked chain */

/* linked element def */

typedef struct elem {
	sid symbol_name;
	symb_value_type symbol_value;
	struct elem * next;
} elem;

typedef struct container {
	elem * table;
	struct container * next;
} container;

static container * st = NULL;


/* linked chain initial element */
//static elem** tables=NULL;

static int init=0;

container* createContainer(container* next)
{
	container* c = malloc(sizeof(container));
	c->next=next;
	c->table=NULL;
	return c;
}

//create a nex storage and replace st by the new one
void moreStorage()
{
	container* c = createContainer(st);
	c->table=NULL;

	st=c;
}


void lessStorage()
{
	container* c = st;
	st = st->next;
	free(c);


}



/* get the symbol value of symb_id from the symbol table */
symb_value_type get_symbol_value(sid symb_id) {
	if (init == 0)
	{
		st = malloc(sizeof(container));
		st->next=NULL;
		st->table=NULL;
		init = 1;
	}
	elem * tracker=st->table;

	/* look into the linked list for the symbol value */
	while (tracker) {
		if (tracker -> symbol_name == symb_id) return tracker -> symbol_value;
		tracker = tracker -> next;
	}

	/* if not found does cause an error */
	fprintf(stderr,"Error : symbol %s have no defined value\n",(char *) symb_id);
	exit(-1);
};

/* set the value of symbol symb_id to value */
symb_value_type set_symbol_value(sid symb_id,symb_value_type value) {

	if (init == 0)
	{
		st = malloc(sizeof(container));
		init = 1;
	}

	elem * tracker;

	/* (optionnal) check that sid is valid symbol name and exit error if not */
	if (! sid_valid(symb_id)) {
		fprintf(stderr,"Error : symbol id %p is not have no valid sid\n",symb_id);
		exit(-1);
	}

	/* look for the presence of symb_id in storage */

	tracker = st->table;
	while (tracker) {
		if (tracker -> symbol_name == symb_id) {
			tracker -> symbol_value = value;
			return tracker -> symbol_value;
		}
		tracker = tracker -> next;
	}

	/* otherwise insert it at head of storage with proper value */


	tracker = malloc(sizeof(elem));
	tracker -> symbol_name = symb_id;
	tracker -> symbol_value = value;
	tracker -> next = st->table;
	st->table = tracker;
	return st->table -> symbol_value;
}
