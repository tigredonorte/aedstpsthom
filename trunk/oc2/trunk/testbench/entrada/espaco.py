
def espaco(file_in, file_out):
	
	f = open(file_in)
	line = f.readline()
	fout = open(file_out, 'w')
	while(line):
		line = "%s %s %s %s"%(line[:2], line[2:4], line[4:6], line[6:])
		fout.write(line)
		line = f.readline()
		
	f.close()
	fout.close()
	
	

file_in = 'teste1.hex'
file_out = 'teste1.hex2'
espaco(file_in, file_out)
