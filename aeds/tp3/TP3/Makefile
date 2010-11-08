# Makefile(Adaptado do Netbeans)
# Thompson moreira filgueiras. 
# Email: thom@dcc.ufmg.br

CC = gcc

MKDIR = mkdir

CFLAGS = -Wall -g -lm

OBJDIR=src/objects

ENTRADADIR=entrada

SAIDADIR=saida

PLANILIADIR=planilia

RM = rm -f

MAIN = tp3

file1= branch
file2= file
file3= grafo
file4= guloso
file5= main
file6= tentativa
file7= interface

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
	@${MAKE}  -f Makefile ${MAIN}

${MAIN}: ${OBJS}
	@${LINK.c} -o $(MAIN) ${OBJS}

${OBJDIR}/${file1}.o: Makefile src/${file1}.c
	@${MKDIR} -p ${OBJDIR}
	@${RM} $@.d
	@$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file1}.o src/${file1}.c

${OBJDIR}/${file2}.o: Makefile src/${file2}.c
	@${MKDIR} -p ${OBJDIR}
	@${RM} $@.d
	@$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file2}.o src/${file2}.c

${OBJDIR}/${file3}.o: Makefile src/${file3}.c
	@${MKDIR} -p ${OBJDIR}
	@${RM} $@.d
	@$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file3}.o src/${file3}.c

${OBJDIR}/${file4}.o: Makefile src/${file4}.c
	@${MKDIR} -p ${OBJDIR}
	@${RM} $@.d
	@$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file4}.o src/${file4}.c

${OBJDIR}/${file5}.o: Makefile src/${file5}.c
	@${MKDIR} -p ${OBJDIR}
	@${RM} $@.d
	@$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file5}.o src/${file5}.c

${OBJDIR}/${file6}.o: Makefile src/${file6}.c
	@${MKDIR} -p ${OBJDIR}
	@${RM} $@.d
	@$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file6}.o src/${file6}.c

${OBJDIR}/${file7}.o: Makefile src/${file7}.c
	@${MKDIR} -p ${OBJDIR}
	@${RM} $@.d
	@$(COMPILE.c) -g -Wall -O3 -MMD -MP -MF $@.d -o ${OBJDIR}/${file7}.o src/${file7}.c

# Limpar
clean: ${CLEAN}
	@${RM} -r ${OBJDIR}
	@${RM} ${MAIN}

# Rodar testes
run: ${MAIN}
	@make build
	./$(MAIN) -s 2 -i $(ENTRADADIR)/entrada.txt -o $(SAIDADIR)/teste.txt -t $(PLANILIADIR)/teste.ods
	@make clean

debug:	
	@make build
	valgrind --leak-check=full ./${MAIN} -s 1 -i $(ENTRADADIR)/entrada.txt -o $(SAIDADIR)/saida.txt -t $(PLANILIADIR)/saida.ods
	@make clean

gerar:	
	@make build
	
		
	@echo "BATERIA DE TESTE 1 -- MANTENDO VERTICES VARIANDO ARESTAS -- 7 VERTICES"
	@echo "Teste 1: grafo desconexo"
	@echo "Tentativa e erro"
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/tentativa_desconexo.txt -t $(PLANILIADIR)/tentativa_desconexo.ods
	
	@echo "Branch and bound"
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/branch_desconexo.txt -t $(PLANILIADIR)/branch_desconexo.ods
	
	@echo "guloso"
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/desconexo7vertices.txt -o $(SAIDADIR)/guloso_desconexo.txt -t $(PLANILIADIR)/guloso_desconexo.ods
	
		
	@echo "Teste 2: grafo com 12 arestas"
	@echo "Tentativa e erro"
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	
	@echo "Branch and bound"
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	
	@echo "guloso"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conectado7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	
	@echo "Teste 3: grafo conexo"
	@echo "Tentativa e erro"
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)tentativa_conexo.txt -t $(PLANILIADIR)/$(file)tentativa_conexo.ods
	
	@echo "Branch and bound"
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)branch_conexo.txt -t $(PLANILIADIR)/$(file)branch_conexo.ods
	
	@echo "guloso"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)conexo7vertices.txt -o $(SAIDADIR)/$(file)guloso_conexo.txt -t $(PLANILIADIR)/$(file)guloso_conexo.ods
	
	
	@echo "BATERIA DE TESTE 2 -- MANTENDO ARESTAS VARIANDO VERTICES -- 15 VERTICES"
	@echo "Teste 1: grafo 7vertices"
	@echo "Tentativa e erro"
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)tentativa_7vertices.txt -t $(PLANILIADIR)/$(file)tentativa_7vertices.ods
	
	@echo "Branch and bound"
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)branch_7vertices.txt -t $(PLANILIADIR)/$(file)branch_7vertices.ods
	
	@echo "guloso"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)7vertices.txt -o $(SAIDADIR)/$(file)guloso_7vertices.txt -t $(PLANILIADIR)/$(file)guloso_7vertices.ods	
	
		
	
	@echo "Teste 2: grafo 9vertices"
	@echo "Tentativa e erro"
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)tentativa_9vertices.txt -t $(PLANILIADIR)/$(file)tentativa_9vertices.ods
	
	@echo "Branch and bound"
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)branch_9vertices.txt -t $(PLANILIADIR)/$(file)branch_9vertices.ods
	
	@echo "guloso"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)9vertices.txt -o $(SAIDADIR)/$(file)guloso_9vertices.txt -t $(PLANILIADIR)/$(file)guloso_9vertices.ods
	
	
	@echo "Teste 3: grafo 11vertices"
	
	@echo "Tentativa e erro"
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	./${MAIN} -s 1 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)tentativa_11vertices.txt -t $(PLANILIADIR)/$(file)tentativa_11vertices.ods
	
	@echo "Branch and bound"
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	./${MAIN} -s 2 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)branch_11vertices.txt -t $(PLANILIADIR)/$(file)branch_11vertices.ods
	
	@echo "guloso"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)11vertices.txt -o $(SAIDADIR)/$(file)guloso_11vertices.txt -t $(PLANILIADIR)/$(file)guloso_11vertices.ods	
	
	@echo "guloso"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)13vertices.txt -o $(SAIDADIR)/$(file)guloso_13vertices.txt -t $(PLANILIADIR)/$(file)guloso_13vertices.ods	
	
	@echo "BATERIA DE TESTE 3 -- TESTANDO GULOSO PARA ENTRADAS MAIORES"
	@echo "Teste 1: grafo 87 vertices"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso87.txt -o $(SAIDADIR)/$(file)guloso_87.txt -t $(PLANILIADIR)/$(file)guloso_87.ods
	
	@echo "Teste 1: grafo 100 vertices"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso100.txt -o $(SAIDADIR)/$(file)guloso_100.txt -t $(PLANILIADIR)/$(file)guloso_100.ods
	
	@echo "Teste 1: grafo 255 vertices"
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods
	./${MAIN} -s 3 -i $(ENTRADADIR)/$(fileTeste)guloso255.txt -o $(SAIDADIR)/$(file)guloso_255.txt -t $(PLANILIADIR)/$(file)guloso_255.ods		
	
	@make clean
	
