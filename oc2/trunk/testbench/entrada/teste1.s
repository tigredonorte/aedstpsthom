.text
.globl __start
__start :
addi   $a0 , $zero , 100
slt    $a1 , $zero , $a0
sw     $a0 , 0( $gp )
add    $a2 , $a1 , $a0
nop
nop
nop
nop
nop

