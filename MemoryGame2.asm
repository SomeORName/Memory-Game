bits 16
org 0x7C00
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

mov esp,0xffff
;;start of screen initialization
mov al,0x11
;left side
mov edi, 0xB8001;
xor ecx,ecx
f1:
cmp ecx,25
jge end1
mov [edi],al;1
add edi,2
mov [edi],al;2
sub edi,2
add edi,160
inc ecx
jmp f1
end1 :
;col 1
mov edi, 0xB8001;
add edi, 24
xor ecx,ecx
fx:
cmp ecx,25
jge endx
mov [edi],al;
add edi,2
mov [edi],al;
sub edi,2
add edi,160
inc ecx
jmp fx
endx :
;col 2
mov edi, 0xB8001;
add edi, 48
xor ecx,ecx
f2:
cmp ecx,25
jge end2
mov [edi],al;
add edi,2
mov [edi],al;
sub edi,2
add edi,160
inc ecx
jmp f2
end2 :
;col 3
mov edi, 0xB8001;
add edi, 72
xor ecx,ecx
f3:
cmp ecx,25
jge end3
mov [edi],al;
add edi,2
mov [edi],al;
sub edi,2
add edi,160
inc ecx
jmp f3
end3 :
;col 4
mov edi, 0xB8001;
add edi, 96
xor ecx,ecx
f4:
cmp ecx,25
jge end4
mov [edi],al;
add edi,2
mov [edi],al;
sub edi,2
add edi,160
inc ecx
jmp f4
end4 :
;col 5
mov edi, 0xB8001;
add edi, 156
xor ecx,ecx
f5:
cmp ecx,25
jge end5
mov [edi],al;
add edi,2
mov [edi],al;
sub edi,2
add edi,160
inc ecx
jmp f5
end5 :
;raw 1
mov edi, 0xB8001;
xor ecx,ecx
f6:
cmp ecx,80
jge end6
mov [edi],al;
add edi,2
inc ecx
jmp f6
end6 :
;raw 2
mov edi, 0xB8001;
add edi,1280
xor ecx,ecx
f7:
cmp ecx,50
jge end7
mov [edi],al;
add edi,2
inc ecx
jmp f7
end7 :
;raw 3
mov edi, 0xB8001;
add edi,2560
xor ecx,ecx
f8:
cmp ecx,50
jge end8
mov [edi],al;
add edi,2
inc ecx
jmp f8
end8 :
;raw 3
mov edi, 0xB8001;
add edi,3840
xor ecx,ecx
f9:
cmp ecx,80
jge end9
mov [edi],al;
add edi,2
inc ecx
jmp f9
end9 :
;Head
mov edi,0xb8000
add edi,596
mov dl,[main_msg]
xor ecx,ecx
print_main:
cmp dl,0
je main_end
mov [edi],dl
mov dl,0x0f
inc edi
mov [edi],dl
inc edi
inc ecx;for string (memroy game)
mov dl,[main_msg+ecx]
jmp print_main
main_end:
;;end of screen initialization

;;drawing shapes into the screen
;store the shapes in the blocks in arr (in order)
xor eax,eax
ff:
cmp eax,12 ;eax numbers of block
jge eend
mov ebx,[arr+4*eax] ;arr shapes block numbers
mov ecx,1 ;1  for shspe
push eax
push $
jmp shape
pop eax
inc eax
jmp ff
eend:
rdtsc;cycles from the begining of programm
mov ebx,eax
mov ecx,0x1312d00;cycles  (2*10^10) n89tha 3$an al bits
div ecx;seconds from begingig of programm
mov ebp,eax
delay:
rdtsc
mov ebx,eax
mov ecx,0x1312d00;cycles  (2*10^10) n89tha 3$an al bits ; 2*10^7
div ecx;seconds from begingig of programm
;eax cotains second 
sub eax, ebp
cmp eax,700
jl delay
;;delay ??!!

;;erasing shapes from the screen
xor eax,eax
ffErase:
cmp eax,16
jge eendErase
mov ebx,[arr]
mov ecx,0
push eax
push $
jmp shape
pop eax
inc eax
jmp ffErase
eendErase:

;;reading input from keyboard
cli
check:
xor ecx,ecx
win_loop:
cmp ecx,12 
jge you_won
mov edx,[opened+4*ecx] 
cmp edx,0
je need_more_tries
inc ecx
jmp win_loop
need_more_tries:
cli
in al,0x64
and al,1
jz check
in al,0x60
;determine the block from input
cmp al,0x0b;0
jne block1
mov eax,0
jmp show
block1:
cmp al,0x02;1
jne block2
mov eax,1
jmp show
block2:
cmp al,0x03;2
jne block3
mov eax,2
jmp show
block3:
cmp al,0x04;3
jne block4
mov eax,3
jmp show
block4:
cmp al,0x05;4
jne block5
mov eax,4
jmp show
block5:
cmp al,0x06;5
jne block6
mov eax,5
jmp show
block6:
cmp al,0x07;6
jne block7
mov eax,6
jmp show
block7:
cmp al,0x08;7
jne block8
mov eax,7
jmp show
block8:
cmp al,0x09;8
jne block9
mov eax,8
jmp show
block9:
cmp al,0x0a;9
jne blockA
mov eax,9
jmp show
blockA:
cmp al,0x1e;A
jne blockB
mov eax,10
jmp show
blockB:
cmp al,0x30;B
jne check
mov eax,11
show:
;check if it is already opened
mov ecx,[opened+4*eax]
cmp ecx,1
je check
;show the shape in the block
mov [first_block],eax
mov ebx,[arr+4*eax]
mov ecx,1
push $
jmp shape
add esp,2
check2:
cli
in al,0x64
and al,1
jz check2
in al,0x60
;determine the block from input
cmp al,0x0b;0
jne block1e
mov eax,0
jmp showe
block1e:
cmp al,0x02;1
jne block2e
mov eax,1
jmp showe
block2e:
cmp al,0x03;2
jne block3e
mov eax,2
jmp showe
block3e:
cmp al,0x04;3
jne block4e
mov eax,3
jmp showe
block4e:
cmp al,0x05;4
jne block5e
mov eax,4
jmp showe
block5e:
cmp al,0x06;5
jne block6e
mov eax,5
jmp showe
block6e:
cmp al,0x07;6
jne block7e
mov eax,6
jmp showe
block7e:
cmp al,0x08;7
jne block8e
mov eax,7
jmp showe
block8e:
cmp al,0x09;8
jne block9e
mov eax,8
jmp showe
block9e:
cmp al,0x0a;9
jne blockAe
mov eax,9
jmp showe
blockAe:
cmp al,0x1e;A
jne blockBe
mov eax,10
jmp showe
blockBe:
cmp al,0x30;B
jne check2
mov eax,11
showe:
;check if it is already opened
mov ecx,[opened+4*eax]
cmp ecx,1
je check2
;check if it is the same block
cmp eax,[first_block]
je check2
;show the shape in the block
mov [second_block],eax
mov ebx,[arr+4*eax]
mov ecx,1
push $
jmp shape
add esp,2
;freeze the screen
rdtsc;cycles from the begining of programm
mov ebx,eax
mov ecx,0x1312d00;cycles  (2*10^10) n89tha 3$an al bits
div ecx;seconds from begingig of programm
mov ebp,eax
delay2:
rdtsc
mov ebx,eax
mov ecx,0x1312d00;cycles  (2*10^10) n89tha 3$an al bits ; 2*10^7
div ecx;seconds from begingig of programm
;eax cotains second 
sub eax, ebp
cmp eax,70
jl delay2

;decrease the counter
dec byte [count]
mov edi,0xb8000
add edi,902
mov dl,[count_msg]
xor ecx,ecx
print_loop:
cmp dl,0
je pend
mov [edi],dl
add edi,2
inc ecx
mov dl,[count_msg+ecx]
jmp print_loop
pend:
mov edx,0
mov dl,[count]
cmp dl,0
jz you_lost
cmp dl,10
jge more_than_10
add dl,0x30
mov [edi],dl
inc edi
mov dl,0xf0
mov [edi],dl
;
add edi,2
mov dl,0x00
mov [edi],dl
jmp check_shapes
more_than_10:
sub dl,10
mov al,[numbers+edx*2]
mov [edi],al
inc edi
mov al,0xf0
mov [edi],al
inc edi
;
mov al,[numbers+edx*2+1]
mov [edi],al
inc edi
mov al,0xf0
mov [edi],al
;check the shapes
check_shapes:
mov eax,[first_block]
mov ebx,[second_block]
mov ecx,[arr+4*eax]
mov edx,[arr+4*ebx]
cmp edx,ecx
jne erase
;equal !
;update 'opened'
mov ecx,1
mov [opened+4*eax],ecx
mov [opened+4*ebx],ecx
jmp check
;erase them
erase:
mov eax,[first_block]
mov ebx,[arr]
mov ecx,0
push $
jmp shape
add esp,2
;
mov eax,[second_block]
mov ebx,[arr]
mov ecx,0
push $
jmp shape
add esp,2
;check again
jmp check

you_won:
;part 1
mov edi,0xb8000
add edi,1712
mov dl,[win_msg_part1]
xor ecx,ecx
win_msg_1:
cmp dl,0
je winend1
mov [edi],dl
add edi,2
inc ecx
mov dl,[win_msg_part1+ecx]
jmp win_msg_1
winend1:
;part 2
mov edi,0xb8000
add edi,1880
mov dl,[win_msg_part2]
xor ecx,ecx
win_msg_2:
cmp dl,0
je winend2
mov [edi],dl
inc edi
mov dl,0xf8
mov [edi],dl
inc edi
inc ecx
mov dl,[win_msg_part2+ecx]
jmp win_msg_2
winend2:
jmp exit
you_lost:
mov edi,0xb8000
add edi,1706
mov dl,[loss_msg]
xor ecx,ecx
loss_msg_loop:
cmp dl,0
je lossend
mov [edi],dl
add edi,2
inc ecx
mov dl,[loss_msg+ecx]
jmp loss_msg_loop
lossend:

;;shapes function
jmp exit ; to prevent using the function without calling
shape:
;how to use the function ?
;put the block number in eax
;put the shape number in ebx
;put color/erase in ecx

;#1
;switch to determine block
mov edi,0xb8000
cmp eax,0
jne case2
add edi,164
jmp end
case2:
cmp eax,1
jne case3
add edi,188
jmp end
case3:
cmp eax,2
jne case4
add edi,212
jmp end
case4:
cmp eax,3
jne case5
add edi,236
jmp end
case5:
cmp eax,4
jne case6
add edi,1444
jmp end
case6:
cmp eax,5
jne case7
add edi,1468
jmp end
case7:
cmp eax,6
jne case8
add edi,1492
jmp end
case8:
cmp eax,7
jne case9
add edi,1516
jmp end
case9:
cmp eax,8
jne case10
add edi,2724
jmp end
case10:
cmp eax,9
jne case11
add edi,2748
jmp end
case11:
cmp eax,10
jne case12
add edi,2772
jmp end
case12:
cmp eax,11
jne case13
add edi,2796
jmp end
case13:
cmp eax,12
jne case14
add edi,4004
jmp end
case14:
cmp eax,13
jne case15
add edi,4028
jmp end
case15:
cmp eax,14
jne case16
add edi,4052
case16:
add edi,4076
end:
;#2
;switch to determine the shape
cmp ebx,0
jne case_2
mov esi,sh1
jmp end_0
case_2:
cmp ebx,1
jne case_3;
mov esi,sh2
jmp end_0
case_3:
cmp ebx,2
jne case_4;
mov esi,sh3
jmp end_0
case_4:
cmp ebx,3
jne case_5;
mov esi,sh4
jmp end_0
case_5:
cmp ebx,4
jne case_6;
mov esi,sh5
jmp end_0
case_6:
cmp ebx,5
jne case_7;
mov esi,sh6
jmp end_0
case_7:
cmp ebx,6
jne case_8;
mov esi,sh7
jmp end_0
case_8:
mov esi,sh8
end_0:
;#3
;;determine whether to draw or erase ,draw=1,erase=0
cmp ecx,0
jne draw
;#4.1
;;erase the block
mov al,0x00
add edi,1
xor ebx,ebx
floope1:
cmp ebx,7
jge end_of_e1
;{
xor ecx,ecx
floope2:
cmp ecx,10
jge end_of_e2
mov [edi],al
add edi,2
inc ecx
jmp floope2
end_of_e2:
;}
add edi,140
inc ebx
jmp floope1
end_of_e1:
jmp return
;#4.2
;;draw the block
draw:
xor edx,edx
xor ebx,ebx
floop1:
cmp ebx,7
jge end_of_1
;{
xor ecx,ecx
floop2:
cmp ecx,10
jge end_of_2
mov al,[esi+edx] ;edx from 0 to 70
mov [edi],al
;make the letters white
mov al,0x0f
inc edi
mov [edi],al
;
inc edi
inc ecx
inc edx
jmp floop2
end_of_2:
;}
add edi,140
inc ebx
jmp floop1
end_of_1:
;#5
;;return
return:
pop ax;
add ax,6;
jmp ax;

;messages
main_msg : db "Memory Game",0
count_msg : db "Number of tries left : ",0
win_msg_part1 : db "Congratulations !",0
win_msg_part2 : db "You Won",0
loss_msg : db "You lost , try again!",0

numbers : db '10','11','12','13','14','15'

count : db 16
first_block : dd -1
second_block : dd -1
arr : dd 0,1,2,3,0,1,2,3,4,5,4,5
opened : dd 0,0,0,0,0,0,0,0,0,0,0,0

sh1 : db '          ','     *****','      *** ','  *    *  ',' ***      ','*****     ','          '
;'          ',
;'     *****',
;'      *** ',
;'  *    *  ',
;' ***      ',
;'*****     ',
;'          '

sh2 : db '****  ****','***    ***','*        *','*        *','**      **','***    ***','****  ****'
;'****  ****',
;'***    ***',
;'*        *',
;'*        *',
;'**      **',
;'***    ***',
;'****  ****'

sh3 : db '    **    ','   ****   ',' ******** ',' ******** ','   ****   ','    **    ','          '
;'    **    ',
;'   ****   ',
;' ******** ',
;' ******** ',
;'   ****   ',
;'    **    ',
;'          '
sh4 : db '    **    ','    **    ','**********','**********','    **    ','    **    ','    **    ',
;'    **    ',
;'    **    ',
;'**********',
;'**********',
;'    **    ',
;'    **    ',
;'    **    ',

sh5 : db '          ','**********','*  ****  *','*   **   *','*   **   *','*  ****  *','***********'
;'          ',
;'**********',
;'*  ****  *',
;'*   **   *',
;'*   **   *',
;'*  ****  *',
;'***********'
sh6 : db '  **  **  ','  **  **  ','    **    ','    **    ','  **  **  ','  **  **  ','          '
;'  **  **  ',
;'  **  **  ',
;'    **    ',
;'    **    ',
;'  **  **  ',
;'  **  **  ',
;'          '

sh7 : db '**      **',' **    ** ','  **  **  ','   ****   ','  **  **  ',' **    ** ','**      **'
;'**      **',
;' **    ** ',
;'  **  **  ',
;'   ****   ',
;'  **  **  ',
;' **    ** ',
;'**      **'

sh8 : db '         *','        * ','       *  ','      *   ',' *   *    ','  * *     ','   *      '
;'         *',
;'        * ',
;'       *  ',
;'      *   ',
;' *   *    ',
;'  * *     ',
;'   *      '

exit:
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
