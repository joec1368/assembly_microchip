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

Advanced:
	SETALL 0x17, 0x10; dividend
	SETALL 0x06, 0x11; divisor
	SETALL 0x00, 0x00;


	LFSR 0, 0x10;
	LFSR 1, 0x11;
	LFSR 2, 0x00;

	RLNCF INDF1;
	RLNCF INDF1;
	RLNCF INDF1;
	RLNCF INDF1;

;first
	MOVF INDF1,w;
	SUBWF INDF0 , w;

	BTFSS STATUS, 4;
		MOVWF INDF0;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		MOVLW 0x01;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		ADDWF INDF2;bit4(positive) == 0;
	CLRF WREG;
	MOVWF STATUS;
	RRNCF INDF1;right
	RLNCF INDF2;left
;second
	MOVF INDF1,w;
	SUBWF INDF0 , w;

	BTFSS STATUS, 4;
		MOVWF INDF0;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		MOVLW 0x01;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		ADDWF INDF2;bit4(positive) == 0;    
	CLRF WREG;
	MOVWF STATUS;
	RRNCF INDF1;
	RLNCF INDF2;
;third
	MOVF INDF1,w;
	SUBWF INDF0 , w;

	BTFSS STATUS, 4;
		MOVWF INDF0;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		MOVLW 0x01;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		ADDWF INDF2;bit4(positive) == 0;    
	CLRF WREG;
	MOVWF STATUS;
	RRNCF INDF1;
	RLNCF INDF2;
;fourth
	MOVF INDF1,w;
	SUBWF INDF0 , w;

	BTFSS STATUS, 4;
		MOVWF INDF0;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		MOVLW 0x01;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		ADDWF INDF2;bit4(positive) == 0; 
	
	CLRF WREG;
	MOVWF STATUS;
	RRNCF INDF1;
	RLNCF INDF2;
;fifth
	MOVF INDF1,w;
	SUBWF INDF0 , w;

	BTFSS STATUS, 4;
		MOVWF INDF0;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		MOVLW 0x01;bit4(positive) == 0;
	BTFSS STATUS, 4;;bit4(negative) == 1;
		ADDWF INDF2;bit4(positive) == 0;
	MOVFF INDF0, 0x01;

MOVLW 0x00
end


