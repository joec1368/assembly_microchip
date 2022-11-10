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

CHANGE macro register1, register2
 		MOVF register1, 0;
 		MOVFF register2, register1;
 		MOVWF register2;
        MOVLW 0x00
	endm
	
Advanced: 
	SETALL 0x0B, 0x10;
	SETALL 0x05, 0x11;
	SETALL 0x40, 0x12;
	SETALL 0x07, 0x13;
	SETALL 0x0D, 0x14;
	SETALL 0x7F, 0x15;
	SETALL 0x0A, 0x16;
	SETALL 0x01, 0x17;
	SETALL 0xFE, 0x18;

	SETALL 0x09, 0x01; max;
	SETALL 0x01, 0x02; current time;

	LFSR 2, 0x011; current number
	LFSR 1, 0x010; pre number;
	LFSR 0, 0x000; number;

Bubble_sort_initial:

	SETALL 0x01, INDF0; renew in-round number

	LFSR 1, 0x010; make pointer point to intial addr
	LFSR 2, 0x011; make pointer point to intial addr

	MOVF 0x01,w; ;	MOVLW 0x09; final_number


	CPFSEQ 0x02
		goto Bubble_sort_loop; !=
	goto endding; ==

Bubble_sort_loop:
	MOVLW 0x00;
	MOVF INDF1, w; w = pre
	CPFSGT INDF2 ; now pre 
		goto CHANGE_State;<=
	goto loop_end;>


CHANGE_State:
	CHANGE INDF1, INDF2;
	goto loop_end;

loop_end:
	INCF FSR1L; make pointer point to next addr
	INCF FSR2L;  make pointer point to next addr
	MOVLW 0x00; 
	INCF INDF0; increase in-round number
	
	MOVF 0x01,w; ;	MOVLW 0x09;
	
	CPFSEQ INDF0
		goto Bubble_sort_loop; !=
	INCF 0x02; == -> increase total-round number 
	goto Bubble_sort_initial; 
	
endding: 
    MOVLW 0x00;
end



