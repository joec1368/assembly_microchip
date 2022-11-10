LIST p=18f4520
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
; a ^ b = (~a&b) | (~b&a)
COMF 0x000, 0 ; W = ~*0x000
ANDWF 0x001, 0 ; W &= *0x001
MOVWF 0x002 ; *0x002 = W
COMF 0x001, 0 ; W = ~*0x001
ANDWF 0x000, 0 ; W &= *0x000
IORWF 0x002
    
end