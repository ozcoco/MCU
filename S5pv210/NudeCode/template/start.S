.global _start
.global main
	
_start:
	B main
loop:
    BL loop
