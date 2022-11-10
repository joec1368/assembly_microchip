#include "xc.inc"
GLOBAL _chen
    
PSECT mytext, local, class=CODE, reloc = 2

 SETALL macro value, register
       MOVLW value
       MOVWF register
       MOVLW 0x00
     endm
     
_chen:
    MOVFF 0x01, 0x10;first
    SETALL 0x00, 0x13; qui
     


Start:
	LFSR 0, 0x10;
	LFSR 2, 0x12;
	
	MOVFF INDF0,INDF2;
	DECF INDF2;
	goto Start_minor_setting
	
    INITIAL:
	MOVLW 0x01;
	SUBWF INDF2,f;
	MOVLW 0x00;
	MOVWF STATUS;
	
    Start_minor_setting:
	MOVFF INDF0, 0x20;
	MOVFF INDF2, WREG
	SETALL 0xff,0x21;

    Minoring:
	MOVFF 0x00, STATUS;
	MOVFF INDF2, WREG
	
	SUBWF 0x20, f ; f - w
	
	
	TSTFSZ 0x20
	    goto judge;!=0
	goto Check;==0

    judge:
    MOVFF 0x21, WREG;
    CPFSGT 0x20
	    MOVFF 0x20, 0x21;
	CPFSGT 0x20
	    goto Minoring;; 0x20<0x21
	; 0x20 > 0x21
	goto INITIAL;
	
    Check:
	MOVLW 0x01;
	CPFSEQ INDF2;
	    SETALL 0xff, 0x01; != 1
	CPFSEQ INDF2;==
	    MOVFF 0x01,WREG;!=
	CPFSEQ INDF2;==
	    goto endding;!=
	SETALL 0x01, 0x01;==
	MOVFF 0x01,WREG;
	    
	    
    endding:
RETURN;