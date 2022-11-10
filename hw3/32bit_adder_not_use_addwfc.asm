LIST p=18f4520

    #include<p18f4520.inc>

	CONFIG OSC = INTIO67

	CONFIG WDT = OFF

	org 0x00

SETALL macro value, register
       MOVLW value
       MOVWF register
       MOVLW 0x00
     endm 

basic:
	SETALL 0x10, 0x00
	SETALL 0x11, 0x01
	SETALL 0x12, 0x02
	SETALL 0xFF, 0x03
	SETALL 0x20, 0x10
	SETALL 0x21, 0x11
	SETALL 0x22, 0x12
	SETALL 0xFF, 0x13

	SETALL 0x04, 0x40 ; counter
	SETALL 0x01, 0x41 ; add 1

	LFSR 0, 0x03
	LFSR 1, 0x13
	LFSR 2, 0x23

basic_loop:
	MOVF POSTDEC0, w;
	BTFSC STATUS, C;
	    ADDWF 0x41, w;plus 1
	BCF STATUS,C
	ADDWF POSTDEC1, w;
	MOVWF POSTDEC2;
	

	CLRF WREG;
	DECFSZ 0x40;
	    goto basic_loop;!=0
	goto basic_end;==0
basic_end:
    MOVLW 0x00;
	end;



