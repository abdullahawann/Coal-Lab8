[org 0x0100] 
jmp start
s1: db 'a man,a plan,a canal,panama!!!', 0
s2: db '                     ', 0
s3: db '                                   ', 0
equal: db 'The given string is palindrome', 0
notequal: db 'The given string is not palindrome', 0

;--------------------------------------------------------------------------------------------------------------------------------------------

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

;--------------------------------------------------------------------------------------------------------------------------------------------

strlen:
push bp
mov bp,sp
push es
push cx
push di
les di,[bp+4]
mov cx,0xffff
xor al,al
cld
repne scasb
mov ax,0xffff
sub ax,cx
dec ax
pop di
pop cx
pop es
pop bp
ret 4

;--------------------------------------------------------------------------------------------------------------------------------------------

compareStr:
push bp
mov bp,sp
push cx
push si
push di
push es
push ds
lds si,[bp+4]
les di,[bp+8]
push ds
push si
call strlen
mov cx,ax
push es
push di
call strlen
cmp cx,ax
jne exitfalse
mov ax,1
repe cmpsb
je exitsimple
exitfalse:
mov ax,0
exitsimple:
pop ds
pop es
pop di
pop si
pop cx
pop bp
ret 8

;--------------------------------------------------------------------------------------------------------------------------------------------        
                             
strlenght:
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

;--------------------------------------------------------------------------------------------------------------------------------------------

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
call strlenght
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

;--------------------------------------------------------------------------------------------------------------------------------------------

newstring:
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
call strlenght
mov cx,ax
loopstring2:
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
mov [s2+di],dl
add di,1
skipstring:
add si,1
cmp si,cx
jnz loopstring2
mov byte[s2+di],0
pop di
pop dx
pop ax
pop cx
pop si
pop bx
pop bp

ret 2

;--------------------------------------------------------------------------------------------------------------------------------------------

reverse:
push bp
mov bp,sp
push ax
push si
push di
push bx
mov bx,[bp+4]
push bx
call strlenght
mov bx,[bp+4]
mov si,ax
dec si
mov di,0
loopstring:
mov ax,[s2+si]
mov [s3+di],ax
inc di
dec si
cmp si,-1
jnz loopstring
mov byte[s3+di],0
pop bx
pop di
pop si
pop ax
pop bp
ret 2

;--------------------------------------------------------------------------------------------------------------------------------------------

start:
call clrscr
mov ax,0
push ax
mov ax,0
push ax
mov ax,s1
push ax 
call printstr
mov ax,s1
push ax
call newstring
mov ax,0
push ax
mov ax,1
push ax
mov ax,s2
push ax
call printstr
mov ax,s2
push ax
call reverse
mov ax,0
push ax
mov ax,2
push ax
mov ax,s3
push ax
call printstr
push ds
mov ax,s2
push ax
push ds
mov ax,s3
push ax
call compareStr
cmp ax,0
jne op2
mov ax,0
push ax
mov ax,3
push ax
mov ax,notequal
push ax
call printstr
jmp terminate
op2:
mov ax,0
push ax
mov ax,3
push ax
mov ax,equal
push ax
call printstr

terminate:
mov ax,0x4c00
int 21h
