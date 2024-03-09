[org 0x0100]

jmp start

String1: db 'I am Abdullah Awan', 0
String2: db '             ', 0

;-------------------------------------------------------------------------------------------------------------------------------------------

clrscr:
push es
push cx
push ax
push di
mov di,0
mov ax,0xb800
mov es,ax
mov ax,0x0720
mov cx,2000
rep stosw
pop di
pop ax
pop cx
pop es
ret

;-------------------------------------------------------------------------------------------------------------------------------------------
   
reverseStr:
push bp
mov bp,sp
push ax
push si
push di
push bx
mov bx,[bp+4]
push bx
call strlen

mov si,ax
dec si
mov di,0
loopstring:
mov ax,[String1+si]
mov [String2+di],ax
inc di
dec si
cmp si,-1
jnz loopstring
pop bx
pop di
pop si
pop ax
pop bp
ret 2

;-------------------------------------------------------------------------------------------------------------------------------------------
                                  
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

;-------------------------------------------------------------------------------------------------------------------------------------------

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

;-------------------------------------------------------------------------------------------------------------------------------------------

start:
call clrscr
mov ax,0
push ax
mov ax,0
push ax
mov ax,String1
push ax 
call printstr
mov ax,String1
push ax
call reverseStr
mov ax,0
push ax
mov ax,0
push ax
mov ax,String2
push ax 
call printstr

mov ax,0x4c00
int 0x21
