
[org 0x7c00] ; offset where BIOS puts our code

    mov bp, 0x8000 ; set stack
    mov sp, bp

    mov bx, 0x9000 ; set where to load to
    mov dh, 2

    call disk_load

    mov dx, [0x9000] ; print loaded data
    call print_hex

    call print_nl

    mov dx, [0x9000+512]
    call print_hex

    jmp $

%include "print_functions.asm"
%include "boot_sect_disk.asm"

times 510-($-$$) db 0

dw 0xaa55 ; boot sector end

times 256 dw 0xdada
times 256 dw 0xface
