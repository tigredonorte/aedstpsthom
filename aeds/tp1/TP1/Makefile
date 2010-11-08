# Makefile(Adaptado do Netbeans)
# Thompson moreira filgueiras. 
# Email: thom@dcc.ufmg.br

CC = gcc

MKDIR = mkdir

CFLAGS = -Wall -g -lpthread -lgsl -lgslcblas

OBJDIR=src/objects

ENTRADADIR=entrada/vocabulario.txt

TESTESDIR=testes/saida

PLANILIADIR=testes/planilha

RM = rm -f

MAIN = tp

#OBJS = main.o data.o dicionario.o fila.o filap.o file.o threads.o gen_data.o
file1= gen_data
file2= data
file3= dicionario
file4= fila
file5= filap
file6= file
file7= threads
file8= main

OBJS= \
        ${OBJDIR}/${file1}.o \
        ${OBJDIR}/${file2}.o \
	${OBJDIR}/${file3}.o \
        ${OBJDIR}/${file4}.o \
        ${OBJDIR}/${file5}.o \
        ${OBJDIR}/${file6}.o \
	${OBJDIR}/${file7}.o \
	${OBJDIR}/${file8}.o

# Construir

build: ${BUILD}
	${MAKE}  -f Makefile tp

tp: ${OBJS}
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

${OBJDIR}/${file8}.o: Makefile src/${file8}.c
	${MKDIR} -p ${OBJDIR}
	${RM} $@.d
	$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file8}.o src/${file8}.c

# Limpar
clean: ${CLEAN}
	${RM} -r src/objetos
	${RM} cp

# Rodar testes
run: ${MAIN}
	make build
	./$(MAIN) -i $(ENTRADADIR) -o outfile.txt -n 100 -t 2 -k 2 -e teste.ods

# Gerar os mesmos testes das estatisticas
gerar: ${MAIN}
	make build 
	@echo " --- Bateria de testes 1 Variando o parametro n (numero de trabalhos) ---\n\n"
	@echo " n = 1000   t = 50    k = 500 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste1.txt -n 1000  -t 50 -k 500 -e $(PLANILIADIR)/teste1.ods
	@echo " n = 5000   t = 50    k = 500 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste2.txt -n 5000  -t 50 -k 500 -e $(PLANILIADIR)/teste2.ods
	@echo " n = 10000  t = 50    k = 500 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste3.txt -n 10000 -t 50 -k 500 -e $(PLANILIADIR)/teste3.ods
	
	@echo " --- Bateria de testes 2 Variando o parametro T (numero de threads) ---\n\n"
	@echo " n = 5000   t = 50    k = 500 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste4.txt -n 5000 -t 50  -k 500 -e $(PLANILIADIR)/teste4.ods
	@echo " n = 5000   t = 100   k = 500 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste5.txt -n 5000 -t 100 -k 500 -e $(PLANILIADIR)/teste5.ods
	@echo " n = 5000   t = 200   k = 500 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste6.txt -n 5000 -t 200 -k 500 -e $(PLANILIADIR)/teste6.ods
	
	@echo " --- Bateria de testes 3 Variando o parametro K (tamanho do buffer) ---\n\n"
	@echo " n = 5000   t = 50    k = 100 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste7.txt -n 5000 -t 50 -k 100  -e $(PLANILIADIR)/teste7.ods
	@echo " n = 5000   t = 50    k = 500 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste8.txt -n 5000 -t 50 -k 500  -e $(PLANILIADIR)/teste8.ods
	@echo " n = 5000   t = 50    k = 1000 ---\n"
	./$(MAIN) -i $(ENTRADADIR) -o $(TESTESDIR)/teste9.txt -n 5000 -t 50 -k 1000 -e $(PLANILIADIR)/teste9.ods

