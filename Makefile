all: emu

boot_sect.bin: *.asm
	nasm -f bin main.asm -o boot_sect.bin

emu: boot_sect.bin
	qemu-system-x86_64 -drive format=raw,file=boot_sect.bin
