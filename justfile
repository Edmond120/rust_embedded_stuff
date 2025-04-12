set export

help:
	just --list

debugger option:
	#!/usr/bin/nu
	match $env.option {
		"connect" => { openocd -f interface/stlink.cfg -f target/stm32f3x.cfg }
		_ => { print "invalid option"; exit 1 }
	}

print option *flags:
	#!/usr/bin/nu
	let flags = $env.flags | split row ' '
	let release = '--release' in $flags
	match $env.option {
		"elf-headers" => {
			if $release {
				cargo readobj --bin app --release -- --file-headers
			} else {
				cargo readobj --bin app -- --file-headers
			}
		}
		"size" => {
			if $release {
				cargo size --bin app --release -- -A
			} else {
				cargo size --bin app -- -A
			}
		}
		"disassemble" => {
			if $release {
				cargo objdump --bin app --release -- --disassemble --no-show-raw-insn --print-imm-hex
			} else {
				cargo objdump --bin app -- --disassemble --no-show-raw-insn --print-imm-hex
			}
		}
		_ => { print "invalid option"; exit 1 }
	}
