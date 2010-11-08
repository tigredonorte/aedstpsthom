# Makefile(Adaptado do Netbeans)
# Thompson moreira filgueiras. 
# Email: thom@dcc.ufmg.br

CC = gcc

MKDIR = mkdir

CFLAGS = -Wall -g -lm

OBJDIR=src/objects

ENTRADADIR=entrada

SAIDADIR=testes

PLANILIADIR=graficos

RM = rm -f

MAIN = tp2

#OBJS = main.o data.o dicionario.o fila.o filap.o file.o threads.o gen_data.o
file1= arvore
file2= dinamica
file3= file
file4= guloso
file5= hashaberto
file6= tentativa
file7= main

OBJS= \
        ${OBJDIR}/${file1}.o \
        ${OBJDIR}/${file2}.o \
	${OBJDIR}/${file3}.o \
        ${OBJDIR}/${file4}.o \
        ${OBJDIR}/${file5}.o \
        ${OBJDIR}/${file6}.o \
	${OBJDIR}/${file7}.o

# Construir

build: ${BUILD}
	${MAKE}  -f Makefile ${MAIN}

${MAIN}: ${OBJS}
	${LINK.c} -o $(MAIN) ${OBJS}

${OBJDIR}/${file1}.o: Makefile src/${file1}.c
	${MKDIR} -p ${OBJDIR}
	${RM} $@.d
	$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file1}.o src/${file1}.c

${OBJDIR}/${file2}.o: Makefile src/${file2}.c
	${MKDIR} -p ${OBJDIR}
	${RM} $@.d
	$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file2}.o src/${file2}.c

${OBJDIR}/${file3}.o: Makefile src/${file3}.c
	${MKDIR} -p ${OBJDIR}
	${RM} $@.d
	$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file3}.o src/${file3}.c

${OBJDIR}/${file4}.o: Makefile src/${file4}.c
	${MKDIR} -p ${OBJDIR}
	${RM} $@.d
	$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file4}.o src/${file4}.c

${OBJDIR}/${file5}.o: Makefile src/${file5}.c
	${MKDIR} -p ${OBJDIR}
	${RM} $@.d
	$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file5}.o src/${file5}.c

${OBJDIR}/${file6}.o: Makefile src/${file6}.c
	${MKDIR} -p ${OBJDIR}
	${RM} $@.d
	$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file6}.o src/${file6}.c

${OBJDIR}/${file7}.o: Makefile src/${file7}.c
	${MKDIR} -p ${OBJDIR}
	${RM} $@.d
	$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file7}.o src/${file7}.c

# Limpar
clean: ${CLEAN}
	${RM} -r ${OBJDIR}
	${RM} ${MAIN}

# Rodar testes
run: ${MAIN}
	make build
	./$(MAIN) -s 2 -i $(ENTRADADIR)/entrada.txt -o $(SAIDADIR)/teste.txt -t $(PLANILIADIR)/teste.ods
	make clean

