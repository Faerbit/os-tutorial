all: emu

boot_sect.bin: boot_sect.asm
	nasm -f bin boot_sect.asm -o boot_sect.bin

emu: boot_sect.bin
	qemu-system-x86_64 -drive format=raw,file=boot_sect.bin
