[org 0x100]

jmp start

String1: db 'Mr. Ali, Usman, & Anwar! Doing what???? want to travel!???', 0
String2: db '                                                          ', 0

;-----------------------------------------------------------------------------------------------------------------------------------------------------

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

;-----------------------------------------------------------------------------------------------------------------------------------------------------                                                     
                                     
strlen:
push bp
mov bp,sp
push es
push di
push cx
push bx
mov cx,0xffff
mov di,[bp+4]
mov al,0
push ds
pop es
repne scasb
mov ax,0xffff
sub ax,cx
dec ax
pop bx
pop cx
pop di
pop es
pop bp
ret 2

;-----------------------------------------------------------------------------------------------------------------------------------------------------

updateStr:
push bp
mov bp,sp
push bx
push si
push cx
push ax
push dx 
push di
mov bx,[bp+4]
mov di,0
mov si,0
push bx
call strlen
mov cx,ax

loopstring:
mov ax,0
mov dx,'a'
push dx
mov dx,'z'
push dx
mov dl,[bx+si]
mov dh,0
push dx
calL checkstring

mov dx,'A'
push dx
mov dx,'Z'
push dx
mov dl,[bx+si]
mov dh,0
push dx
call checkstring

mov dx,'0'
push dx
mov dx,'9'
push dx
mov dl,[bx+si]
mov dh,0
push dx
call checkstring

cmp ax,0
je skipstring
mov [String2+di],dl
add di,1

skipstring:
add si,1
cmp si,cx
jnz loopstring

pop di
pop dx
pop ax
pop cx
pop si
pop bx
pop bp
ret 2

;-----------------------------------------------------------------------------------------------------------------------------------------------------

printstr:
push bp
mov bp,sp
push es
push ax
push di
push cx
push si
mov ax,0xb800
mov es, ax
mov al,80
mul byte[bp+6]
add ax,[bp+8]
shl ax,1
mov di,ax
mov si,[bp+4]
push si
call strlen
mov cx,ax

mov ah,7
cld

print2:
lodsb
stosw
loop print2
pop si
pop cx
pop di
pop ax
pop es
pop bp
ret 6

checkstring:
push bp
mov bp,sp
push dx
push bx
push cx
mov dx,[bp+8]
mov bx,[bp+6]
mov cx,[bp+4]
cmp dx,cx
ja end
cmp bx,cx
jb end
mov ax,1

end:
pop cx
pop bx
pop dx
pop bp
ret 6

;-----------------------------------------------------------------------------------------------------------------------------------------------------

start:
call clrscr
mov ax,0
push ax
mov ax,0
push ax
mov ax, String1
push ax 
call printstr

mov ax, String1
push ax
call updateStr

mov ax, 0
push ax
mov ax, 0
push ax
mov ax, String2
push ax
call printstr

mov ax,0x4c00
int 0x21
