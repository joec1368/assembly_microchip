LIST p=18f4520

    #include<p18f4520.inc>

	CONFIG OSC = INTIO67

	CONFIG WDT = OFF

	org 0x00

basic: 	
	
	MOVLW 0x01 ; WREG = 0x01
	MOVLB 0x1 ; BSR = 1
	MOVWF 0x00, 1 ; [0x100] = 1
	MOVWF 0x01, 1 ; [0x101] = 1
	MOVLW 0x07 ;
	MOVWF 0x10 , 1; [0x110] = 7
	MOVLW 0x00

	LFSR 0, 0x100 ; FSR0 point to 0x100
	LFSR 1, 0x101 ; FSR1 point to 0x101
	LFSR 2, 0x102 ; FSR2 point to 0x102

basic_loop:
	
	MOVF POSTINC0, 0 ; move value from register to wreg
	ADDWF POSTINC1, 0;
	MOVWF POSTINC2 ;
	MOVLW 0x00;
	DECFSZ 0x10 ,1,1;
	    goto basic_loop ; != 
    
MOVLW 0x00;	   
end



