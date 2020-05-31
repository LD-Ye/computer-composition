      .data
englishword: .asciiz "Alpha ","Bravo ","Charlie ","Delta ","Echo ","Foxtrot ","Golf ","Hotel ","India ","Juliet ","Kilo ","Lima ","Mike ","November ","Oscar ","Papa ","Quebec ","Romeo ","Sierra ","Tango ","Uniform ","Victor ","Whisky ","X-ray ","Yankee ","Zulu "
engap: .word 0,7,14,23,30,36,45,51,58,65,73,79,85,91,101,108,114,122,129,137,144,153,161,169,176,184
number: .asciiz "zero ", "one ", "two ", "three ", "four ", "five ", "six ", "seven ","eight ","nine "
numgap: .word 0,6,11,16,23,29,35,40,47,54 
myname:	.asciiz "\r\nLindong\r\n"

 
      .text
      .globl main
main:	li $v0, 12
	syscall
	sub $t1, $v0, 63	# check whether the input is ?
	beqz $t1, exit  #if so exit the program
	sub $t1, $v0, 48 	#48 is the ascii of 0
	slt $s0, $t1, $0	# if t1 < 0 then s0 = 1
	bnez $s0, none # if not englishword or num jump to none
	
	sub $t2, $t1, 10#input is a number
	slt $s1, $t2, $0
	bnez $s1, shownum
	
	# Is the input capital word
	sub $t2, $v0, 91#make the ascii of A 0
	slt $s3, $t2, $0	#if v0<=¡¯z¡¯
	sub $t3, $v0, 64	
	sgt $s4, $t3, $0	#if v0>=¡¯a¡¯
	and $s0, $s3, $s4	 
	bnez $s0, showword	
	
	# is the input not capital word?
	sub $t2, $v0, 123# make the ascii of a 0

	slt $s3, $t2, $0	# if v0 <= 'z' 
	sub $t3,$v0, 96		
	sgt $s4, $t3, $0	# if v0 >= 'a'
	and $s0, $s3, $s4
	bnez $s0, showword
	j none
	
shownum: add $t2, $t2, 10
	sll $t2, $t2, 2
	la $s0, numgap
	add $s0, $s0, $t2
	lw $s1, ($s0)
	#sll $s1, $s1, 1
	la $a0, number
	add $a0, $a0, $s1
	li $v0, 4
	syscall   #print the number
	j main
	
showword:sub $t3, $t3, 1# print the word
	sll $t3, $t3,2
	la $s0, engap
	add $s0, $s0, $t3
	lw $s1, ($s0)
	#sll $s1, $s1, 1
	la $a0, englishword
	add $a0, $s1, $a0
	li $v0, 4
	syscall
	j main
	
none:	and $a0, $0, $0
	add $a0, $a0, 42
	li $v0, 11
	syscall
	j main#ready for other input
	
exit:	la $a0, myname
	li $v0, 4
	syscall
	
 
