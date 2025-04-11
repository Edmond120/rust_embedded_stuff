help:
	just --list

debugger connect:
	openocd -f interface/stlink.cfg -f target/stm32f3x.cfg
