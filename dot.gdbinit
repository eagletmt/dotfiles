set history save on
set history size 10000
set history filename ~/.gdb_history

set print pretty on
set print asm-demangle on
set print demangle on
set disassembly-flavor intel
set print symbol-filename on
set print object on

define al
x /11i $pc
end
