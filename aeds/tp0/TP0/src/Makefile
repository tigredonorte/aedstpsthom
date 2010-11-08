CC = gcc

CFLAGS = -Wall -g -lm

RM = rm -f

OBJS = main.o fila.o file.o

MAIN = aplicativo

$(MAIN): $(OBJS)
	@echo ""
	@echo " --- COMPILANDO PROGRAMA ---"
	@$(CC) $(CFLAGS) $(OBJS) -lm -o $(MAIN)
	@echo ""

%.o: %.c %.h
	@echo " --- COMPILANDO OBJETO \"$@\""
	@$(CC) $(CFLAGS) $< -c 

clean:
	$(RM) $(MAIN) *.o
	clear

run: $(MAIN)
	./$(MAIN) -i ../entradas/entrada.txt -s 2 -n 2 -o ../resultados/saida.txt
