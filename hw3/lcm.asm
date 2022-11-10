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
     


bonus:
	SETALL 0xF5, 0x10; first
	SETALL 0x5A, 0x11; second
	SETALL 0x00, 0x13; qui
	
	LFSR 0, 0x10;
	LFSR 1, 0x11;
	LFSR 2, 0x12;
	
	MOVF INDF0,w;
	MOVFF INDF0,INDF2;
	CPFSLT INDF1;compare which one is smaller
	    goto Left_start
	MOVFF INDF1, INDF2
	goto Left_start
	
    INITIAL:
	MOVLW 0x01;
	SUBWF INDF2,f;
	MOVLW 0x00;
	MOVWF STATUS;
	
    Left_start:
	MOVFF INDF0, 0x20;
	MOVFF INDF2, WREG
	SETALL 0xff,0x21;

    Left_loop:
	MOVFF 0x00, STATUS;
	MOVFF INDF2, WREG
	
	SUBWF 0x20, f ; f - w
	
	
	TSTFSZ 0x20
	    goto left_judge;!=0
	goto Right_start;==0

    left_judge:
    MOVFF 0x21, WREG;
    CPFSGT 0x20
	    MOVFF 0x20, 0x21;
	CPFSGT 0x20
	    goto Left_loop;; 0x20<0x21
	; 0x20 > 0x21
	goto INITIAL;
	
    Right_start:
	MOVFF INDF1, 0x20;
	MOVFF INDF2, WREG
	CLRF 0x13;
	
	MOVFF 0x20,0x21;
    Right_loop:
	MOVLW 0x01;
	ADDWF 0x13,f;??++
	
	MOVFF 0x00, STATUS;
	MOVFF INDF2, WREG
	
	SUBWF 0x20, f ; f - w
	

	TSTFSZ 0x20
	    goto right_judge;!=0
	goto Already_find;==0

	right_judge:
    MOVFF 0x21, WREG;
	CPFSGT 0x20
	    MOVFF 0x20, 0x21;; 0x20<0x21
    CPFSGT 0x20
	    goto Right_loop;;
	; 0x20 > 0x21
	goto INITIAL;
	
Already_find:
    ;???????????
    MOVFF 0x13, WREG;
    MULWF INDF0;
    
    MOVFF PRODH, 0x00;
    MOVFF PRODL, 0x01;
    
    
    MOVLW 0x00;
end