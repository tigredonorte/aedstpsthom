.text
.globl __start
__start :
addi $s1 , $zero , 0x0001
sll $s2 , $s1 , 16
add $gp , $zero , $s2
addi $s1 , $zero , 0x00ff
sll $s2 , $s1 , 16
add $s3 , $s2 , $zero
sll $s2 , $s1 , 8
add $s3 , $s3 , $s2
#add $s3 , $s2 , $zero
add $s3 , $s3 , $s1
#addi $s3 , $s2 , 0xff00
add $sp , $zero , $s3
nop
nop
nop
nop

