;;boating  ##rasm ashkal ##delay ##mas7 ashkalt 
;;keyboard:
bits 16
org 0x7C00
;;this code for writing more than 512 lines
cli 
mov ah,0x02
mov al,8
mov dl,0x80
mov dh,0
mov ch,0
mov cl,2
mov bx ,DDD
int 0x13
jmp DDD

times (510 - ($ - $$)) db 0
db 0x55, 0xAA



DDD:
xor ax,ax
mov ss,ax
;;printing press any key to start
mov edi,0xb8038
add edi,1600
 MOV ECX,0
 L:
 mov al,[press+ecx]
 mov [edi],al
 inc ecx
 add edi,2
 cmp ecx,21
 jge tt
 jmp L
tt:
;;to enter key
      start:
      in al,0x64
       and al,1
       jz start
       
 ;to delete press any key to start
 mov edi,0xb8038
mov ecx,1600
add edi,ecx
mov ecx,22
cool:

mov al,0x20
mov [edi],al
add edi,2
loop cool 
; to draw all the shapes(12)
 push $  ;contain current location
     jmp block1;lable contains calling function to draw first shape and then go back to second push ,and so on 
        push $
      jmp block2
     push $
       jmp block3
      push $
       jmp block4
      push $
       jmp block5
      push $
       jmp block6
      push $
       jmp block7
      push $
       jmp block8
       push $
       jmp block9
      push $
       jmp block10
     push $
       jmp block11
      push $
       jmp block12
;code for drawing colums
;first column
u:
xor ECX,ECX
mov edi, 0xB8000
inc edi
x11:
mov al,0x99
mov [edi],al
add edi,0xA0
inc ecx
cmp ecx,25
jl x11
;second column
xor ECX,ECX
mov edi, 0xB8027
a1:
mov al,0x99
mov [edi],al
add edi,0xA0
inc ecx
cmp ecx,25
jl a1
;third column
xor ecx,ecx
mov edi,0xB804F
c1:
mov al,0x99
mov [edi],al
add edi,0xA0;mov to
inc ecx
cmp ecx,25
jl c1
;fourth column
xor ecx,ecx
mov edi,0xB8075
Z1:
mov al,0x99
mov [edi],al
add edi,0xA0;mov to
	inc ecx
cmp ecx,25
jl Z1
;fifth column
xor ecx,ecx
mov edi,0xB809E
INC EDI
o1:
mov al,0x99
mov [edi],al
add edi,0xA0;mov to 160
inc ecx
cmp ecx,25
jl o1
;code fordrawing rows
;first row
xor ecx,ecx
mov edi,0xB8000
inc edi
e1:
mov al,0x99
mov [edi],al
add edi,2
inc ecx
cmp ecx,80
jl e1
;;second row
xor ecx,ecx
mov edi,0xB8000
add edi,0x3C0 
inc edi
k21:
mov al,0x99
mov [edi],al
add edi,2
inc ecx
cmp ecx,59
jl k21
;third row
xor ecx,ecx
mov edi,0xB8000
add edi,0x780 
inc edi
p1:
mov al,0x99
mov [edi],al
add edi,2
inc ecx
cmp ecx,59
jl p1
;fourth row
xor ecx,ecx
mov edi,0xB8000
add edi,0xB40
inc edi
q1:
mov al,0x99
mov [edi],al
add edi,2
inc ecx
cmp ecx,59
jl q1
;fifth row
xor ecx,ecx
mov edi,0xB8000
add edi,0xF00 
inc edi
t1:
mov al,0x99
mov [edi],al
add edi,2
inc ecx
cmp ecx,80
jl t1
;delay
 rdtsc;cycles from the begining of program
mov ebx,eax
mov ecx,0x03938700;cycles for one second
div ecx;seconds from begingig of program
mov ebp,eax
delay:
rdtsc
mov ebx,eax
mov ecx,0x03938700;cycles  for one second
div ecx
;eax cotains second 
sub eax, ebp;eax=(begining of program)-(begining of program+ loop time)
cmp eax,70;best delay time
jl delay
;loop to write memory game
main_msg:
mov edi,0xB8000
add edi,444
xor ecx,ecx
lab1:
mov al,[msg+ecx]
mov [edi],al
inc ecx
add edi,2
cmp ecx,11
jge end
jmp lab1
end:
;code to delete shapes
       mov ebp,0xB8000
        add ebp,374;first shape location
        call shaped;jump to deleting function
       mov ebp,0xB8000
        add ebp,1374;second shape location and so on ,,12 shapes
        call shaped;jump to deleting function
       mov ebp,0xB8000
        add ebp,3294
        call shaped;jump to deleting function
      mov ebp,0xB8000
        add ebp,334
        call shaped;jump to deleting function
    mov ebp,0xB8000
        add ebp,2254
        call shaped;jump to deleting function
      mov ebp,0xB8000
        add ebp,3214
        call shaped;jump to deleting function
        mov ebp,0xB8000
        add ebp,414
        call shaped;jump to deleting function
        mov ebp,0xB8000
        add ebp,2294
        call shaped ;jump to deleting function
        mov ebp,0xB8000
        add ebp,1294
        call shaped;jump to deleting function
        mov ebp,0xB8000
        add ebp,2334
        call shaped;jump to deleting function
     mov ebp,0xB8000
        add ebp,1334
        call shaped;jump to deleting function
      mov ebp,0xB8000
        add ebp,3254
        call shaped;jump to deleting function
        ;write 1 in first square,1 is key needed from keyboard to draw or delete shape, and so on 
        ;we use keys from 0-9 and -,=
        ;code to write 1 ,4,7and0 in corresponding squares
      mov edi,0xB8000
add edi,164
mov ecx,0
col1:
mov al,[ecx+col]
mov [edi],al
add edi,960
inc ecx
cmp ecx,5
jge col2
jmp col1
;code to write  2,5,8and - in corresponding squares
  col2:      
    mov edi,0xB8000
add edi,204
mov ecx,0
col22:
mov al,[ecx+coll]
mov [edi],al
add edi,960
inc ecx
cmp ecx,5
jge col3
jmp col22
;code to write 3,6,9and= in corresponding squares
    col3:
        mov edi,0xB8000
add edi,244
mov ecx,0
col33:
mov al,[ecx+colll]
mov [edi],al
add edi,960
inc ecx
cmp ecx,5
jge ee
jmp col33
  ee:      
cli
xor ax,ax
mov ss,ax;fast key pressed from keyboard
mov esi,0;counter for win
push esi
mov ebp,0;counter for total number of pressing
push ebp
	check: 
        ;to recieve input from player
        in al,0x64
        and al,1
        jz check
        in al,0x60 
        ;;; compare al with make key
        cmp al,0x00 
        jl check
        CMP aL,02;make code for key 1
        je sqr4 ;go to corresponding sqaure for key 1,and so on
        cmp al,03;make code for key 2
        je sqr1
        cmp al,04;make code for key 3
        je sqr7
        cmp al,05;make code for key 4
        je sqr9
        cmp al,06;make code for key 5
        je sqr11
        cmp al,07;make code for key 6
       je sqr2
        cmp al,08;make code for key 7
        je sqr5
        cmp al,09;make code for key 8
        je sqr8
        cmp al,0x0A;make code for key 9
        je sqr10
        cmp al,0x0B;make code for key 0
        je sqr6
        cmp al,0x0C;make code for key -
        je sqr12
        cmp al,0x0D;make code for key =
        je sqr3
        jmp check
        ;draw the required shape
        sqr1:
         mov bl,al
        mov [labb],bl;contain first key
        push $ 
         jmp block1
        mov ecx,1
        mov dl,[ecx+table2];table2 contains one number for every simillar shape 
        ;dl contain number corresponding shape for first key
        ;it help us to know if they are simillar or deffrent and so on
        jmp check2
        
        sqr2: 
         mov bl,al
        mov [labb],bl
       push $
         jmp block2
        mov ecx,5
        mov dl,[ecx+table2]
        jmp check2
        sqr3:
        mov bl,al
        mov [labb],bl
       push $
         jmp block3
        mov ecx,11
        mov dl,[ecx+table2]
        jmp check2
        sqr4:
        mov bl,al
        mov [labb],bl
       push $
         jmp block4
        mov ecx,0
        mov dl,[ecx+table2]
        jmp check2
        sqr5:
        mov bl,al
        mov [labb],bl
        push $
         jmp block5
        mov ecx,6
        mov dl,[ecx+table2]
       jmp check2
        
        sqr6:
         mov bl,al
        mov [labb],bl
       push $
         jmp block6
        mov ecx,9
        mov dl,[ecx+table2]
        jmp check2
        sqr7:
         mov bl,al
        mov [labb],bl
       push $
         jmp block7
        mov ecx,2
        mov dl,[ecx+table2]
        jmp check2
        sqr8:
         mov bl,al
        mov [labb],bl
       push $
         jmp block8
        mov ecx,7
        mov dl,[ecx+table2]
        jmp check2        
        sqr9:
         mov bl,al
        mov [labb],bl
       push $
         jmp block9
        mov ecx,3
        mov dl,[ecx+table2]
        jmp check2        
        sqr10:
         mov bl,al
        mov [labb],bl
       push $
         jmp block10
        mov ecx,8
        mov dl,[ecx+table2]
        jmp check2        
        sqr11:
         mov bl,al
        mov [labb],bl
       push $
         jmp block11
        mov ecx,4
        mov dl,[ecx+table2]
        jmp check2   
        sqr12:
         mov bl,al
        mov [labb],bl
       push $
         jmp block12
        mov ecx,10
        mov dl,[ecx+table2]
        jmp check2
        
       check2:;to recieve second key  
       ;;cmpare al with make code for second key
       ;same as check
       mov [labd],dl
        in al,0x64
        and al,1
        jz check2
        in al,0x60 
        cmp al,0x00 
        jl check2
        cmp al,bl 
        je check
        CMP aL,02
        je sqrr4
        cmp al,03
        je sqrr1
        cmp al,04
        je sqrr7
        cmp al,05
        je sqrr9
        cmp al,06
        je sqrr11
        cmp al,07
       je sqrr2
        cmp al,08
        je sqrr5
        cmp al,09
        je sqrr8
        cmp al,0x0A
        je sqrr10
        cmp al,0x0B;0
        je sqrr6
        cmp al,0x0C
        je sqrr12
        cmp al,0x0D;=
        je sqrr3
        jmp check
        ;draw required shape
        sqrr1:
        mov [laba],al
         push $
         jmp block1
        mov dl,[labd]
        mov ecx,1
        mov cl,[ecx+table2]; cl contain number corresponding to shape
        cmp dl,cl;to know if the numbers the same they are simillar else different
        je similar
        jmp different
        
        sqrr2:
        mov [laba],al
        push $
         jmp block2
        mov dl,[labd]
        mov ecx,5
        mov cl,[ecx+table2]
        cmp dl,cl
        je similar
        jmp different
        
        sqrr3:
        mov [laba],al
        push $
         jmp block3
        mov dl,[labd]
        mov ecx,11
        mov cl,[ecx+table2]
        cmp dl,cl
        je similar
        jmp different
        
        sqrr4:
        mov [laba],al
        push $
         jmp block4
        mov dl,[labd]
        mov ecx,0        
        mov cl,[ecx+table2]
        cmp dl,cl
        je similar
        jmp different        
        sqrr5:
        mov [laba],al
       push $
         jmp block5
        mov dl,[labd]
        mov ecx,6
        mov cl,[ecx+table2]
        je similar
        jmp different
        
        sqrr6:
        mov [laba],al
        push $
         jmp block6
        mov dl,[labd]
        mov ecx,9
        mov cl,[ecx+table2]
        cmp dl,cl
        je similar
        jmp different
        
        sqrr7:
        mov [laba],al
        push $
         jmp block7
        mov dl,[labd]
        mov ecx,2
        mov cl,[ecx+table2]
        cmp dl,cl
        je similar
        jmp different
        
        sqrr8:
        mov [laba],al
       push $
         jmp block8
        mov dl,[labd]
        mov ecx,7
        mov cl,[ecx+table2]
        cmp dl,cl
        je similar
        jmp different
        
        sqrr9:
        mov [laba],al
        push $
         jmp block9
        mov dl,[labd]
        mov ecx,3
        mov cl,[ecx+table2]
        cmp dl,cl
        je similar
        jmp different
        
        sqrr10:
   mov [laba],al
         push $
         jmp block10
        mov dl,[labd]
        mov ecx,8
        mov cl,[ecx+table2]         
        cmp dl,cl
        je similar
        jmp different
        
        sqrr11:
       mov [laba],al
             push $
         jmp block11
        mov dl,[labd]
        mov ecx,4
        mov cl,[ecx+table2]       
        cmp dl,cl
        je similar
        jmp different
        
        sqrr12:
        mov [laba],al
              push $
         jmp block12
        mov dl,[labd]
        mov ecx,10
        mov cl,[ecx+table2]
        cmp dl,cl
        je similar
        jmp different
        
        similar:
         mov bl,[labb];first key
        mov al,[laba];second key
        cmp al ,bl ;if player press the same key twice go to check2
        je check2
      pop ebp
      inc ebp
      pop esi
      inc esi
      cmp ebp,7 ;total number of counters 7*2
       jge gy
       cmp esi,6 ;if the player win before total number of counters
      je you_win
       push esi
       push ebp
       
        jmp check
       different:
      
        mov bl,[labb];fist key 
        ;for deleting different shapes
       CMP bL,02
        je sqr42
        cmp bl,03
        je sqr125
        cmp bl,04
        je sqr72
        cmp bl,05
        je sqr92
        cmp bl,06
        je sqrb2
        cmp bl,07
       je sqr22
        cmp bl,08
        je sqr52
        cmp bl,09
        je sqr82
        cmp bl,0x0A
        je sqra2
        cmp bl,0x0B
        je sqr62
        cmp bl,0x0C
        je sqrc2
        cmp bl,0x0D
        je sqr32
        
        
        jmp check
        
        sqr125:
       mov ebp,0xB8000
        add ebp,374
        call shaped;jump to deeting function
       jmp d
        
        sqr22: 
       mov ebp,0xB8000
        add ebp,1374
        call shaped;jump to function
       jmp d
        
        sqr32:
       mov ebp,0xB8000
        add ebp,3294
        call shaped;jump to function
        jmp d
       
        
        sqr42:
      mov ebp,0xB8000
        add ebp,334
        call shaped;jump to function
       jmp d
        
        sqr52:
    mov ebp,0xB8000
        add ebp,2254
        call shaped;jump to function
        jmp d
       
        
        sqr62:
      mov ebp,0xB8000
        add ebp,3214
        call shaped;jump to function
       jmp d
        sqr72:
        mov ebp,0xB8000
        add ebp,414
        call shaped;jump to function
       jmp d
        sqr82:
        mov ebp,0xB8000
        add ebp,2294
        call shaped ;jump to function
      jmp d
        sqr92:
        mov ebp,0xB8000
        add ebp,1294
        call shaped;jump to function
       jmp d
        sqra2:
        mov ebp,0xB8000
        add ebp,2334
        call shaped;jump to function
        jmp d
        sqrb2:
     mov ebp,0xB8000
        add ebp,1334
        call shaped;jump to function
      jmp d
        sqrc2:
      mov ebp,0xB8000
        add ebp,3254
        call shaped;jump to function
          jmp d
       d: 
       ;;al contain second make key ,cmpare it with make
       mov al,[laba]
       CMP aL,02
        je sqrd1
        cmp al,03
        je sqra1
        cmp al,04
        je sqrg1
        cmp al,05
        je sqri1
        cmp al,06
        je sqrk11
        cmp al,07
       je sqrb1
        cmp al,08
        je sqre1
        cmp al,09
        je sqrh1
        cmp al,0x0A
        je sqrj1
        cmp al,0x0B
        je sqrf1
        cmp al,0x0C
        je sqrl1
        cmp al,0x0D
        je sqrc1
        
        jmp check
        ;;delete required shape
        sqra1:
       mov ebp,0xB8000
        add ebp,374
        call shaped;jump to function
          pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqrb1: 
       mov ebp,0xB8000
        add ebp,1374
        call shaped;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqrc1:
         mov ebp,0xB8000
        add ebp,3294
        call shaped;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
         sqrd1:
        mov ebp,0xB8000
        add ebp,334
        call shaped;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqre1:
         mov ebp,0xB8000
        add ebp,2254
        call shaped;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqrf1:
        mov ebp,0xB8000
        add ebp,3214
       call shaped;jump to function
        pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqrg1:
         mov ebp,0xB8000
        add ebp,414
        call shaped ;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqrh1:
        mov ebp,0xB8000
        add ebp,2294
        call shaped ;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqri1:
         mov ebp,0xB8000
        add ebp,1294
        call shaped;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqrj1:
        mov ebp,0xB8000
        add ebp,2334
        call shaped;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqrk11:
       mov ebp,0xB8000
        add ebp,1334
        call shaped;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
        sqrl1:
         mov ebp,0xB8000
        add ebp,3254
        call shaped ;jump to function
         pop ebp
       inc ebp
       cmp ebp,7
       jge gy
       push ebp
        jmp check
 shaped:
 ;;deleting function
 rdtsc
mov ebx,eax
mov ecx,0x03938700
div ecx
mov [save],ebp
mov ebp,eax
delay2:
rdtsc
mov ebx,eax
mov ecx,0x03938700
div ecx
sub eax, ebp
cmp eax,7
jl delay2
 mov ebp,[save]
 
 mov bl,0x20
        mov ecx,-1
        
        sq1:
      inc ecx   
       mov edi,ebp
        mov eax,160
        mul ecx
       add edi,eax
        mov esi,-1
        cmp ecx,4
        jge exitd
        sqb:
        inc esi
        cmp esi,5
        jge sq1
        mov [edi],bl
        add edi,2
        jmp sqb
        exitd:ret   
        
          ;first shape
             block1:
          mov eax,arr1
        mov [shapearr],eax
        mov eax,[x1]
        mov [shapex],eax
        mov eax,[y1]
        mov [shapey],eax
        mov eax,[w]
        mov [shapew],eax
        mov eax,[h]
        mov [shapeh],eax;push ip
        call shape;jump to function 
        ;to return  
        pop ax
        add ax,6
        jmp ax 
        
        block2:  
       mov eax,arr2
        mov [shapearr],eax
        mov eax,[x2]
        mov [shapex],eax
        mov eax,[y2]
        mov [shapey],eax
        mov eax,[w2]
        mov [shapew],eax
        mov eax,[h2]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop ax
        add ax,6
        jmp ax 
        block3:
        mov eax,arr3
        mov [shapearr],eax
        mov eax,[x3]
        mov [shapex],eax
        mov eax,[y3]
        mov [shapey],eax
        mov eax,[w3]
        mov [shapew],eax
        mov eax,[h3]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop ax
        add ax,6
        jmp ax   
        block4:
         mov eax,arr4
        mov [shapearr],eax
        mov eax,[x4]
        mov [shapex],eax
        mov eax,[y4]
        mov [shapey],eax
        mov eax,[w4]
        mov [shapew],eax
        mov eax,[h4]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx 
        block5: 
         mov eax,arr5
        mov [shapearr],eax
        mov eax,[x5]
        mov [shapex],eax
        mov eax,[y5]
        mov [shapey],eax
        mov eax,[w5]
        mov [shapew],eax
        mov eax,[h5]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx 
         block6: 
         mov eax,arr6
        mov [shapearr],eax
        mov eax,[x6]
        mov [shapex],eax
        mov eax,[y6]
        mov [shapey],eax
        mov eax,[w6]
        mov [shapew],eax
        mov eax,[h6]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx    
         block7: 
         mov eax,arr7
        mov [shapearr],eax
        mov eax,[x7]
        mov [shapex],eax
        mov eax,[y7]
        mov [shapey],eax
        mov eax,[w7]
        mov [shapew],eax
        mov eax,[h7]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx 
         block8: 
         mov eax,arr8
        mov [shapearr],eax
        mov eax,[x8]
        mov [shapex],eax
        mov eax,[y8]
        mov [shapey],eax
        mov eax,[w8]
        mov [shapew],eax
        mov eax,[h8]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx 
         block9: 
         mov eax,arr9
        mov [shapearr],eax
        mov eax,[x9]
        mov [shapex],eax
        mov eax,[y9]
        mov [shapey],eax
        mov eax,[w9]
        mov [shapew],eax
        mov eax,[h9]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx 
         block10: 
         mov eax,arra
        mov [shapearr],eax
        mov eax,[xa]
        mov [shapex],eax
        mov eax,[ya]
        mov [shapey],eax
        mov eax,[wa]
        mov [shapew],eax
        mov eax,[ha]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx 
         block11: 
         mov eax,arrb
        mov [shapearr],eax
        mov eax,[xb]
        mov [shapex],eax
        mov eax,[yb]
        mov [shapey],eax
        mov eax,[wb]
        mov [shapew],eax
        mov eax,[hb]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx 
         block12: 
         mov eax,arrc
        mov [shapearr],eax
        mov eax,[xc]
        mov [shapex],eax
        mov eax,[yc]
        mov [shapey],eax
        mov eax,[wc]
        mov [shapew],eax
        mov eax,[hc]
        mov [shapeh],eax;push ip
        call shape;jump to function   
        pop dx
        add dx,6
        jmp dx   

shape:
mov ecx,-1;i

A:
inc ecx
mov esi,0;j
cmp ecx,[shapeh];contain hieght(row)
jge exit
B:
cmp esi,[shapew];cmpare it with width(column)
jge A
mov eax,[shapew];cntain width
mul ecx ;i*w
add eax,esi;i*+j
add eax,[shapearr];(i*w+j)+array address
mov bl,byte[eax];contain first letter of array
mov ebp,ecx 
add ebp,[shapex];i+x
mov eax,80
mul ebp;(i+x)*80
mov edi,esi
add edi,[shapey];j+y
add eax,edi;(i+x)*80+j+y
mov ebp,2
mul ebp;((i+x)*80+j+y)*2
add eax,0xB8000;((i+x)*80+j+y)*2+screen address
mov edi,eax
mov [edi],bl
inc esi
jmp B
exit:
;;return
ret

        
arr1:db'A  AA AAA'

x1:dd 2
y1:dd 27
w:dd 3
h:dd 3
arr2:db'p   p   p'
x2:dd 8
y2:dd 47
w2:dd 3
h2:dd 3
arr3:db'A  AA AAA'
x3:dd 20
y3:dd 47
w3:dd 3
h3:dd 3
arr4:db'p   p   p'
x4:dd 2
y4:dd 7
w4:dd 3
h4:dd 3
arr5:db' $ $ $ $ '
x5:dd 14
y5:dd 7
w5:dd 3
h5:dd 3
arr6:db' $ $ $ $ '
x6:dd 20
y6:dd 7
w6:dd 3
h6:dd 3
arr7:db'ooooooooo'
x7:dd 2
y7:dd 47
w7:dd 3
h7:dd 3
arr8:db'ooooooooo'
x8:dd 14
y8:dd 27
w8:dd 3
h8:dd 3
arr9:db' + + + + '
x9:dd 8
y9:dd 7
w9:dd 3
h9:dd 3
arra:db' + + + + '
xa:dd 14
ya:dd 47
wa:dd 3
ha:dd 3
arrc:db'! !! ! ! '
xc:dd 20
yc:dd 27
wc:dd 3
hc:dd 3
arrb:db'! !! ! ! '
xb:dd 8
yb:dd 27
wb:dd 3
hb:dd 3
labd:db 0
labc:db 0
labb:db 0
laba:db 0
labs:db 0
lable1:db 0
lable2:db 0
shapearr:dd 0
shapex:dd 0
shapey:dd 0
shapeh:dd 0
shapew:dd 0
press:db'press any key to play'
col:db'1470'
coll:db'258-'
colll:db'369='
second:dd 0
save:dd 0
msg:db'MEMORY GAME'
lost:db'YOU LOST'
won:db'YOU WON'
msg2:db'!!!!!!'
	gy:
      cmp esi,6
      je you_win
      jmp gh	
;ScanCodeTable: db "//1234567890-="
table2:db"123451634652"
you_win:
;loop to write you won
mov edi, 0xB8000;
 ADD EDI,1724
 MOV ECX,0
 LA1:
 mov al,[ecx+won]
 mov [edi],al
 inc ecx
 add edi,2
 cmp ecx,7
 jge en
 jmp LA1
 ;;loop to write !!!!!!!
 en:
 mov edi, 0xB8000;
 ADD EDI,2044
 MOV ECX,0
 LA:
 mov al,[ecx+msg2]
 mov [edi],al
 inc ecx
 add edi,2
 cmp ecx,7
 jge exit5
 jmp LA
       
gh:

;loop to write you lost
mov edi, 0xB8000;
 ADD EDI,1724
 MOV ECX,0
 Labe:
 mov al,[ecx+lost]
 mov [edi],al
 inc ecx
 add edi,2
 cmp ecx,8
 jge exit5
 jmp Labe
 
        
exit5:
times (0x400000 - 512) db 0

db 	0x63, 0x6F, 0x6E, 0x65, 0x63, 0x74, 0x69, 0x78, 0x00, 0x00, 0x00, 0x02
db	0x00, 0x01, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
db	0x20, 0x72, 0x5D, 0x33, 0x76, 0x62, 0x6F, 0x78, 0x00, 0x05, 0x00, 0x00
db	0x57, 0x69, 0x32, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x78, 0x04, 0x11
db	0x00, 0x00, 0x00, 0x02, 0xFF, 0xFF, 0xE6, 0xB9, 0x49, 0x44, 0x4E, 0x1C
db	0x50, 0xC9, 0xBD, 0x45, 0x83, 0xC5, 0xCE, 0xC1, 0xB7, 0x2A, 0xE0, 0xF2
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00