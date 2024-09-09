.data
    msg_count: .asciiz "¿Cuántos números de la serie Fibonacci desea generar?: "
    msg_fib:   .asciiz "Serie Fibonacci: "
    msg_sum:   .asciiz "La suma de la serie es: "
    newline:   .asciiz "\n"

.text
.globl main
main:
    # Pedir cuántos números desea generar
    li $v0, 4                    # Imprimir cadena
    la $a0, msg_count             # Cargar la dirección del mensaje
    syscall

    li $v0, 5                    # Leer un entero
    syscall
    move $t0, $v0                # Guardar en $t0 el número de términos a generar

    # Si el número de términos es menor que 1, salir
    blez $t0, exit

    # Inicializar los primeros dos números de Fibonacci
    li $t1, 0                    # Fib(0) = 0
    li $t2, 1                    # Fib(1) = 1
    li $t3, 0                    # Suma de la serie
    li $t4, 2                    # Contador de términos generados

    # Imprimir el mensaje "Serie Fibonacci: "
    li $v0, 4                    
    la $a0, msg_fib
    syscall

    # Imprimir Fib(0)
    li $v0, 1                    
    move $a0, $t1                # Pasar Fib(0) a $a0
    syscall

    # Imprimir nueva línea
    li $v0, 4
    la $a0, newline
    syscall

    # Si el número de términos es 1, solo imprimir Fib(0)
    beq $t0, 1, sum_series

    # Imprimir Fib(1)
    li $v0, 1                    
    move $a0, $t2                # Pasar Fib(1) a $a0
    syscall

    # Imprimir nueva línea
    li $v0, 4
    la $a0, newline
    syscall

    # Agregar Fib(0) y Fib(1) a la suma
    add $t3, $t3, $t1
    add $t3, $t3, $t2

    # Bucle para generar los términos restantes de Fibonacci
fib_loop:
    add $t5, $t1, $t2            # t5 = Fib(n) = Fib(n-1) + Fib(n-2)

    # Imprimir Fib(n)
    li $v0, 1                    
    move $a0, $t5
    syscall

    # Imprimir nueva línea
    li $v0, 4
    la $a0, newline
    syscall

    # Agregar Fib(n) a la suma
    add $t3, $t3, $t5

    # Actualizar los valores de Fib(n-2) y Fib(n-1)
    move $t1, $t2                # Fib(n-2) = Fib(n-1)
    move $t2, $t5                # Fib(n-1) = Fib(n)

    # Incrementar el contador de términos
    addi $t4, $t4, 1
    blt $t4, $t0, fib_loop        # Si no se han generado suficientes términos, repetir

# Mostrar la suma de la serie
sum_series:
    li $v0, 4                    # Imprimir "La suma de la serie es: "
    la $a0, msg_sum
    syscall

    li $v0, 1                    # Imprimir la suma
    move $a0, $t3
    syscall

    # Imprimir nueva línea
    li $v0, 4
    la $a0, newline
    syscall

# Finalizar programa
exit:
    li $v0, 10                   # Terminar el programa
    syscall
