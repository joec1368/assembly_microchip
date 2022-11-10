LIST p=18f4520
    #include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00
	

SETALL macro value, register
		MOVLW value;
		MOVWF register;
		CLRF WREG
	endm

initial:
    
    SETALL 0x00,0x00
    SETALL 0x07, 0x10; wanted value
    rcall Hanoitower
    rcall endding


Hanoitower:
	
	DECFSZ 0x10
		rcall Hanoitower
	MOVLW 0x02 ;
	MULWF 0x00;
	MOVFF PRODL, WREG;
	INCF WREG;
	MOVFF WREG, 0x00;
	RETURN;

endding:
	CLRF WREG
end


