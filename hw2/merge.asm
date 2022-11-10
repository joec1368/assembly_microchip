LIST p=18f4520

    #include<p18f4520.inc>

	CONFIG OSC = INTIO67

	CONFIG WDT = OFF

	org 0x00


SETALLINBANK macro value, register
   MOVLW value
   MOVWF register , 1
   MOVLW 0x00
 endm 

	MOVLB 0x1 ; BSR = 1
	
	SETALLINBANK 0xa1, 0x00;
	SETALLINBANK 0xb2, 0x01;
	SETALLINBANK 0xc3, 0x02;
	SETALLINBANK 0xd4, 0x03;
	SETALLINBANK 0xe5, 0x04;

	SETALLINBANK 0x00, 0x05;
	
	SETALLINBANK 0xa7, 0x10;
	SETALLINBANK 0xb3, 0x11;
	SETALLINBANK 0xc9, 0x12;
	SETALLINBANK 0xf6, 0x13;

	
	LFSR 0, 0x100; make pointer point to intial addr
	LFSR 1, 0x110; make pointer point to intial addr
	LFSR 2, 0x120; make pointer point to intial addr

bonus_loop:
	TSTFSZ INDF0;
		goto judge;!=
	goto right_loop ; == 0

judge:
	TSTFSZ INDF1;
		goto bonus_start;!=
	goto left_loop ; == 0

bonus_start:

	MOVF INDF1 , w; w = second array
	CPFSGT INDF0 ; first array vs second array
		goto left_small;<=
	goto right_small;>

left_small:
	MOVFF POSTINC0, POSTINC2
	goto bonus_loop;

right_small:

	MOVFF POSTINC1, POSTINC2
	goto bonus_loop;

right_loop:

	TSTFSZ INDF1;
		goto right_loop_start;!=
	goto bonus_end; == 0

right_loop_start:

	MOVFF POSTINC1, POSTINC2
	goto right_loop;

left_loop:

	TSTFSZ INDF0;
		goto left_loop_start;!=
	goto bonus_end ; == 0

left_loop_start:

	MOVFF POSTINC0, POSTINC2
	goto left_loop;

bonus_end:
    MOVLW 0x00
end






