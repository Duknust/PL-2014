OBJS = linkedList.o lex.yy.o 
CC = gcc
CFLAGS = -g
LIBS = -ll
luthor = luthor.fl
FILES = linkedList.c luthor.fl linkedList.h Makefile

linkedList.o:linkedList.c linkedList.h
	$(CC) $(CFLAGS) -c linkedList.c

lex.yy.c:$(luthor)
	flex $(luthor)

lex.yy.o:lex.yy.c linkedlist.h
	$(CC) $(CFLAGS) -c lex.yy.c

clean:
	rm *.o
	rm lex.yy.c

debug::$(OBJS)
	$(CC) $(CFLAGS) -o $(OBJS) $(LIBS) -g

info:
	@echo "to compile, just run \"make\""
	@echo "\"make clean\" deletes all object files"
	@echo "\"make install\" puts the executable file in the PATH (needs sudo)"
	@echo "\"make remove\" removes the executable from the PATH (needs sudo)"
	@echo "\"make tar\" compresses every file necessary for the build in a tar.gz file"