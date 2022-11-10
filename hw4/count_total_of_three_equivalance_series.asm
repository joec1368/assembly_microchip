

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
    
    SETALL 0x03 , 0x10; a1
    SETALL 0x08 , 0x20; r
    SETALL 0x03, 0x30; counter
    LFSR 0, 0x10;

    rcall GP
    rcall endding


GP:
	
	CLRF STATUS
	CLRF WREG

	MOVFF POSTINC0, WREG;
	MULWF 0x20;
	MOVFF PRODL, INDF0;

	MOVLW GP
	DECFSZ 0x30
		MOVWF PCL;
	MOVLW 0x00;
	MOVFF WREG,STATUS;
	MOVFF 0x10, WREG;
	ADDWFC 0x11,W;
	ADDWFC 0x12,W
	MOVWF 0x02;

	RETURN;

endding:
	CLRF WREG
end
