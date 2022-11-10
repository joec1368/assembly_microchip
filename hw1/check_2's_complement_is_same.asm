
    LIST p = 18f4520
	#include<p18f4520.inc>
	    CONFIG OSC = INTIO67
	    CONFIG WDT = OFF
	    org 0x00
	    

    MOVLW b'00000001'
    MOVWF 0x10
    clrf 0x00
    clrf 0x01
    clrf 0x02
    
    MOVLW 0x7c
    MOVWF 0x00
    MOVLW 0x04
    MOVWF 0x01
    
basic:
    
    COMF 0x00
    INCF 0x00
    
    MOVF 0x00, 0 
    SUBWF 0x01, 0
    MOVWF 0x02
    
    MOVLW 0x00
    CPFSEQ 0x02
	goto not_equal
    goto equal
equal:
    MOVLW 0xFF
    MOVWF 0x02
    goto basic_next
not_equal:
    MOVLW 0x01
    MOVWF 0x02
    goto basic_next
basic_next:
    MOVLW 0xFC
    MOVWF 0x00
    MOVLW 0x04
    MOVWF 0x01
    DCFSNZ 0x10
	goto basic
    goto advanced_initial

advanced_initial:
    clrf 0x00
    clrf 0x01
    clrf 0x02
    clrf 0x10
    MOVLW 0x08
    MOVWF 0x10
    MOVLW b'00010111'
    MOVWF 0x01
advanced_loop:
    MOVLW 0x01
    ANDWF 0x01, 0
    MOVWF 0x11
    TSTFSZ 0x11
	INCF 0x02
    RRNCF 0x01
    DECFSZ 0x10
	goto advanced_loop
    goto bonus_initial
bonus_initial:
    clrf 0x00
    clrf 0x01
    clrf 0x02
    clrf 0x10
    clrf 0x11
    
    MOVLW b'00001111'
    MOVWF 0x00
    MOVLW b'00110011'
    MOVWF 0x01
    
    ANDWF 0x00 ,0
    MOVWF 0x10
    COMF 0x10
    
    MOVF 0x01, 0 
    IORWF 0x00, 0
    ANDWF 0x10, 0
    MOVWF 0x02
    clrf 0x00
    clrf 0x01
    clrf 0x02
    clrf 0x10
    
    

end
	
	
	
    

