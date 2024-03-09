[org 0x0100] 

jmp start 

;---------------------------------------------------------------------------------------------------------------------------------------

clrscr: 
push es 
push ax 
push di 
mov ax, 0xb800 
mov es, ax 
mov di, 0

nextloc: 
mov word [es:di], 0x0720  
add di, 2 
cmp di, 4000 
jne nextloc 
pop di 
pop ax 
pop es 
ret 
 
;---------------------------------------------------------------------------------------------------------------------------------------

delay:
push cx
mov cx,10

delayloop:
push cx
mov cx, 0xffff

delayloop2:
loop delayloop2
pop cx
loop delayloop
pop cx

ret

;---------------------------------------------------------------------------------------------------------------------------------------

printCounter: 
push bp 
mov bp, sp 
push es 
push ax 
push bx 
push cx 
push dx 
push di 
mov ax, 0xb800 
mov es, ax
mov ax, [bp+4] 
mov bx, 10
mov cx, 0  

nextdigit: 
mov dx, 0
div bx 
add dl, 0x30  
push dx  
inc cx 
cmp ax, 0 
jnz nextdigit 
mov di, [bp+6]

nextpos:
pop dx 
mov dh, 0x07 
mov [es:di], dx  
add di, 2 
loop nextpos 
pop di 
pop dx 
pop cx 
pop bx 
pop ax 
pop es 
pop bp 
ret 2 

;---------------------------------------------------------------------------------------------------------------------------------------

start: 
mov ax, 0
mov di,0

l1:
call clrscr 
push di
push ax 
call printCounter
call delay
add ax,2
add di,1
cmp di,4000
jne l1

mov ax,0x4c00
int 0x21
