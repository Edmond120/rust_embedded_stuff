help:
	just --list

debugger connect:
	openocd -f interface/stlink.cfg -f target/stm32f3x.cfg

print elf-headers:
	cargo readobj --bin app -- --file-headers
