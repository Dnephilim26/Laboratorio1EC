.data
    msg_count: .asciiz "¿Cuántos números desea comparar (mínimo 3, máximo 5)?: "
    msg_input: .asciiz "Ingrese el número: "
    msg_result: .asciiz "El menor número es: "
    newline:   .asciiz "\n"

.text
.globl main
main:
    # Pedir cuántos números desea comparar
    li $v0, 4                    # Imprimir cadena
    la $a0, msg_count             # Cargar la dirección del mensaje
    syscall

    li $v0, 5                    # Leer un entero
    syscall
    move $t0, $v0                # Guardar en $t0 el número de comparaciones

    # Verificar si el número de comparaciones es menor a 3 o mayor a 5
    li $t1, 3                    # Mínimo 3
    li $t2, 5                    # Máximo 5
    blt $t0, $t1, exit            # Si es menor que 3, salir
    bgt $t0, $t2, exit            # Si es mayor que 5, salir

    # Inicializar el menor número
    li $t3, 2147483647            # Número más grande posible (para comparar)

    # Bucle para pedir números y encontrar el menor
    li $t4, 0                    # Contador de números ingresados

input_loop:
    li $v0, 4                    # Imprimir mensaje "Ingrese el número"
    la $a0, msg_input
    syscall

    li $v0, 5                    # Leer un número
    syscall
    move $t5, $v0                # Guardar el número ingresado en $t5

    # Comparar el número ingresado con el menor actual
    bge $t5, $t3, no_update       # Si el número ingresado es mayor o igual, no actualizar
    move $t3, $t5                # Actualizar el menor número

no_update:
    addi $t4, $t4, 1             # Incrementar el contador de números
    bge $t4, $t0, show_result    # Si se han ingresado todos los números, mostrar resultado
    j input_loop                 # Volver a pedir el siguiente número

# Mostrar el resultado
show_result:
    li $v0, 4                    # Imprimir "El menor número es: "
    la $a0, msg_result
    syscall

    li $v0, 1                    # Imprimir el menor número
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
