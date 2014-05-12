/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     SEPN = 258,
     LOAD = 259,
     SAVE = 260,
     RANKING = 261,
     EXIT = 262,
     LISTING = 263,
     INFO = 264,
     CONF = 265,
     DB = 266,
     RESULT = 267,
     PROVAS = 268,
     PARTICIPANTES = 269,
     PROVA = 270,
     TORNEIO = 271,
     ficheiro = 272,
     prova = 273
   };
#endif
/* Tokens.  */
#define SEPN 258
#define LOAD 259
#define SAVE 260
#define RANKING 261
#define EXIT 262
#define LISTING 263
#define INFO 264
#define CONF 265
#define DB 266
#define RESULT 267
#define PROVAS 268
#define PARTICIPANTES 269
#define PROVA 270
#define TORNEIO 271
#define ficheiro 272
#define prova 273




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 11 "consola.y"
{
	char* tipoficheiro;
	int tiponProva;
}
/* Line 1529 of yacc.c.  */
#line 90 "consola.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE consolalval;

