.data
    success_string: .asciiz  "\nSuccess! Location: "
    fail_string:  .asciiz  "\nFail!
    buffer: .space 20
  

.text
.globl  main
main:
   
   li $a3,0
   li $t0,0

   #input string
   la $a0,buffer
   li $a1,20
   li $v0,8
   syscall

inputchar:
    li $v0,12
    syscall
    beq $v0,'?',exit  #if input ? then exit
    move  $a2,$v0

search:
    beq $t0,$a1,fail       #if m equals to length then failure
    la $a0,buffer                #else load 
    add $t2,$a0,$t0           
    lb  $s1,($t2)               
    beq $s1,$a2,success        #if$s1 = $a2,then success
    add $t0,$t0,1               
    j search

fail:
    add $a3,$zero,1            # failure = 1
    add $t0,$zero,$zero        #  m = 0

    la $a0,fail_string
    li $v0,4
    syscall

    add $a0,$zero,'\n'
    li $v0,11
    syscall
    j inputchar

success:
    la $a0,success_string
    li $v0,4
    syscall

    li $v0,1
    add $a0,$t0,1            #print index
    syscall

    add $a0,$zero,'\n'
    li $v0,11
    syscall
    add $t0,$zero,0          # m= 0
    j inputchar

exit:
  

    li  $v0,10                #exit
    syscall
