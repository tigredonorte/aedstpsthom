import os

def run(file1, file2):
	os.system('cver %s > saida'%file1)
	os.system('diff saida %s'%file2)

file1 = 'Alu.v'
file2 = '../testesmodulos/modelos/modelo_tb_alu.txt'
run(file1, file2)
	
