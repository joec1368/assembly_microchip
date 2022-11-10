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

DIST macro x1, y1, x2, y2, F1, F2 
 
		
		SETALL x1,0x10;
		MOVLW x2;
		SUBWF 0x10, W;
		MOVFF WREG, 0x10;
		MULWF 0x10;
		MOVFF PRODH, 0x20;
		MOVFF PRODL, 0x21;

		
		SETALL y1,0x11;
		MOVLW y2;
		SUBWF 0x11, W;
		MOVFF WREG, 0x11;
		MULWF 0x11;
		MOVFF PRODH, 0x30;
		MOVFF PRODL, 0x31;

		MOVLW 0x00;
		MOVFF WREG, STATUS;
		MOVFF 0x21, WREG;
		ADDWFC 0x31,W;
		MOVFF WREG,0x41;
		MOVFF 0x20, WREG;
		ADDWFC 0x30,W;
		MOVFF WREG,0x40;
		
		
		MOVFF 0x40, F1;
		MOVFF 0x41, F2;


	endm

initial:
    DIST 0xA5,0xBB, 0x2C, 0x19, 0x00, 0x01;

    CLRF WREG;
end


