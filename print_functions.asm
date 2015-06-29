print_string: ; prints string which is located at [bx]
    pusha

    mov ah, 0x0e ; set to scrolling terminal
    ; loop through null terminated string
    loop:
        mov al, [bx]
        cmp al, 0
        je done
        ; print al to screen
        int 0x10
        add bx, 1
        jmp loop

    done:
        popa
        ret

print_nl: ; prints newline
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10

    popa
    ret

print_hex: ; prints hex from
    pusha

    mov cx, 0 ; index variable

    hex_loop:
        cmp cx, 4 ; cx: index variable, loop 4 times
        je end

        mov ax, dx
        and ax, 0x000f ; masking
        add al, 0x30   ; convert to ascii number
        cmp al, 0x39   ; if >9 add extra 8 to represetn a to f
        jle step2
        add al, 7

    step2:
        mov bx, HEX_OUT + 5 ; base + length
        sub bx, cx ; cx: index variable
        mov [bx], al ; copy the ascii char on al to the position pointed by bx
        ror dx, 4 ; rotate right

        add cx, 1 ; increment index and loop
        jmp hex_loop

    end:
        mov bx, HEX_OUT
        call print_string

    popa
    ret

; global variables
HEX_OUT: db '0x0000', 0
