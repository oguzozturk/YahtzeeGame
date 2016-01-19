
TITLE Program Template     (Yahtzee.asm)

INCLUDE Irvine32.inc

.data

;declare the strings or variables

totPoint BYTE "Total Score:",0
wronginput BYTE "Wrong input.Please enter a number between 1-12:",0
dice BYTE "Dice: ",0
arrayRandomDice SDWORD 5 DUP(0)
arrayRandomReroll SDWORD 5 DUP(0)
arrayOrder BYTE 1d,2d,3d,4d,5d,6d,7d,8d,9d,10d,11d,12d
arrayCombination BYTE "Ones","Twos","Threes","Fours","Fives","Sixs","3 of a kind","4 of a kind","Yahtzee","4 in a row","5 in a row","Anything",0
arrayScore SDWORD 12 DUP(0)
arrayIndex SDWORD 12 DUP(0)
changeDices BYTE 0dh,0ah,"Choose the dice that you want to reroll(enter 0 to exit):",0
changePlace BYTE 0dh,0ah,"Choose the place that you want to fill:",0
count DWORD 0d
sum DWORD 0d
lpc DWORD 0d
tmp DWORD 0d

;pressKey EQU <BYTE "Press enter to roll the dice....",0>
welcome BYTE "Welcome to yahtzee game",0
tit	BYTE "Order   Combination    Score",0       ;Title of table
s1	BYTE "1       Ones             ",0			;First row of ready-table
s2	BYTE "2	Twos             ",0				;Second row of ready-table
s3	BYTE "3	Threes           ",0				;Third row of ready-table
s4	BYTE "4	Fours            ",0				;Fourth row of ready-table
s5	BYTE "5	Fives            ",0				;Fifth row of ready-table
s6	BYTE "6	Sixs             ",0				;Sixth row of ready-table
s7	BYTE "7	3 of a kind      ",0				;Seventh row of ready-table
s8	BYTE "8	4 of a kind      ",0				;Eigtht row of ready-table
s9	BYTE "9	Yahtzee          ",0				;Nineth row of ready-table
s10	BYTE "10 	4 in a row       ",0			;Tenth row of ready-table
s11	BYTE "11	5 in a row       ",0			;Eleventh row of ready-table
s12	BYTE "12	Anything         ",0			;Twelfth row of ready-table

errormassage BYTE "This combination is already selected,Try another one!",0ah,0ah     ;error message
	
;prompt BYTE pressKey

.code
main PROC


;call the Proc 
call everything 
call everything 
call everything 
call everything 
call everything 
call everything 
call everything 
call everything 
call everything 
call everything 
call everything 
 
;-------------------; 
;Proc that include procedures abaout code
 
everything PROC

call tablo
call WaitMsg

;Roll dice 5 times
call randomize
mov ecx,LENGTHOF arrayRandomDice
mov edx,OFFSET dice
mov esi,0

L1:
	call WriteString	
	mov eax,6	
	call RandomRange
	add eax,1	
	call WriteDec
	call Crlf	
	mov arrayRandomDice[esi],eax	
	add esi,TYPE arrayRandomDice
	loop L1


;First Reroll dices
mov edx,OFFSET changeDices
call WriteString
call Crlf
mov ecx,LENGTHOF arrayRandomDice
mov esi,0

L2:

	call ReadInt
	mov esi,eax
	dec esi	
	cmp esi,-1
	je firstRerollDisplay
	imul esi,4
	call randomize
	mov eax,6
	call randomRange
	add eax,1	
	mov arrayRandomDice[esi],eax
	loop L2
	
firstRerollDisplay:

;First Reroll Display dices
mov ecx,LENGTHOF arrayRandomDice
mov edx,OFFSET dice
mov esi,0

displayloop1:
	call WriteString	
	mov eax,arrayRandomDice[esi]
	call WriteDec	
	call Crlf
	add esi,TYPE arrayRandomDice
	loop displayloop1
	
;Second Reroll dices
mov edx,OFFSET changeDices
call WriteString
call Crlf
mov ecx,LENGTHOF arrayRandomDice
mov esi,0

rerollAgain:

	call ReadInt
	mov esi,eax
	dec esi	
	cmp esi,-1
	je secondRerollDisplay
	imul esi,4
	call randomize
	mov eax,6
	call randomRange
	add eax,1
	mov arrayRandomDice[esi],eax
	loop rerollAgain

secondRerollDisplay:

;Second Display dices
call Crlf
mov ecx,LENGTHOF arrayRandomDice
mov edx,OFFSET dice
mov esi,0

L3:
	call WriteString	
	mov eax,arrayRandomDice[esi]
	call WriteDec	
	call Crlf
	add esi,TYPE arrayRandomDice
	loop L3

;______________________________;	
;Compare for filling the table

IO: mov edx,OFFSET changePlace
call WriteString
call ReadInt
mov ebx,eax

cmp ebx,1d
je K1
jl K13

cmp ebx,2d
je K2

cmp ebx,3d
je K3

cmp ebx,4d
je K4

cmp ebx,5d
je K5

cmp ebx,6d
je K6

cmp ebx,7d
je K7

cmp ebx,8d
je K8

cmp ebx,9d
je K9

cmp ebx,10d
je K10

cmp ebx,11d
je K11

cmp ebx,12d
je K12
jg K13

jmp Quit

;//////////////////////////;
;Compare for table cells

K1:mov eax,arrayIndex[0]
cmp eax,0
je Ones
jne GG

K2:mov eax,arrayIndex[4]
cmp eax,0
je Twos
jne GG

K3:mov eax,arrayIndex[8]
cmp eax,0
je Threes
jne GG

K4:mov eax,arrayIndex[12]
cmp eax,0
je Fours
jne GG

K5:mov eax,arrayIndex[16]
cmp eax,0
je Fives
jne GG

K6:mov eax,arrayIndex[20]
cmp eax,0
je Sixes
jne GG

K7:mov eax,arrayIndex[24]
cmp eax,0
je Threeofakind
jne GG

K8:mov eax,arrayIndex[28]
cmp eax,0
je Fourofakind
jne GG

K9:mov eax,arrayIndex[32]
cmp eax,0
je Yahtzee
jne GG

K10:mov eax,arrayIndex[36]
cmp eax,0
je FourInaRow
jne GG

K11:mov eax,arrayIndex[40]
cmp eax,0
je FiveInaRow
jne GG

K12:mov eax,arrayIndex[44]
cmp eax,0
je Anything
jne GG

;If there is a error return back and ask question again
GG:
call Crlf
mov edx,OFFSET errormassage
call WriteString
mov ebx,eax
jmp IO

;Check if for the number between 1-12
K13:
	call Crlf	
	mov edx,OFFSET 	wronginput
	call WriteString
	call Crlf
	jmp IO

;/////////////////////////////////;	
;Control of cases

Ones: 
	mov ecx,LENGTHOF arrayRandomDice
	mov esi,0

Case1:

	mov eax,arrayRandomDice[esi]
	cmp eax,1
	je cnt1
	jne dn1

	
	cnt1:
	inc count
	push eax
	mov eax,count
	pop eax
	
	dn1:
	add esi,4
	
	mov eax,count
	mov arrayScore[0],eax
	call Crlf
	loop Case1
	
	;Category is not empty any more
	mov arrayIndex[0],1

	jmp Quit
	
;|||||||||||||||||||||||||||||||;
	
Twos: 
	mov ecx,LENGTHOF arrayRandomDice
	mov esi,0

Case2:

	mov eax,arrayRandomDice[esi]
	cmp eax,2
	je cnt2
	jne dn2

	
	cnt2:
	inc count
	push eax
	mov eax,count
	pop eax
	
	dn2:
	add esi,4
	
	mov eax,count
	imul eax,2
	mov arrayScore[4],eax
	call Crlf
	loop Case2	

	;Category is not empty any more
	mov arrayIndex[4],1
	
	jmp Quit

;|||||||||||||||||||||||||||||||;	
	
Threes: 
	mov ecx,LENGTHOF arrayRandomDice
	mov esi,0

Case3:

	mov eax,arrayRandomDice[esi]
	cmp eax,3
	je cnt3
	jne dn3

	
	cnt3:
	inc count
	push eax
	mov eax,count
	pop eax
	
	dn3:
	add esi,4
	
	mov eax,count
	imul eax,3
	mov arrayScore[8],eax
	call Crlf
	loop Case3
	
	;Category is not empty any more
	mov arrayIndex[8],1
	
	jmp Quit
	
;|||||||||||||||||||||||||||||||;

Fours: 
	mov ecx,LENGTHOF arrayRandomDice
	mov esi,0

Case4:

	mov eax,arrayRandomDice[esi]
	cmp eax,4
	je cnt4
	jne dn4

	
	cnt4:
	inc count
	push eax
	mov eax,count
	pop eax
	
	dn4:
	add esi,4
	
	mov eax,count
	imul eax,4
	mov arrayScore[12],eax
	call Crlf
	loop Case4
	
	;Category is not empty any more
	mov arrayIndex[12],1
	
	jmp Quit
	
;|||||||||||||||||||||||||||||||;

Fives: 
	mov ecx,LENGTHOF arrayRandomDice
	mov esi,0

Case5:

	mov eax,arrayRandomDice[esi]
	cmp eax,5
	je cnt5
	jne dn5

	
	cnt5:
	inc count
	push eax
	mov eax,count
	pop eax
	
	dn5:
	add esi,4
	
	mov eax,count
	imul eax,5
	mov arrayScore[16],eax
	call Crlf
	loop Case5
	
	;Category is not empty any more
	mov arrayIndex[16],1
	
	jmp Quit

;|||||||||||||||||||||||||||||||;	
	
Sixes: 
	mov ecx,LENGTHOF arrayRandomDice
	mov esi,0

Case6:

	mov eax,arrayRandomDice[esi]
	cmp eax,6
	je cnt6
	jne dn6

	
	cnt6:
	inc count
	push eax
	mov eax,count
	pop eax
	
	dn6:
	add esi,4
	
	mov eax,count
	imul eax,6
	mov arrayScore[20],eax

	call Crlf
	loop Case6
	
	;Category is not empty any more
	mov arrayIndex[20],1
	
	jmp Quit

;|||||||||||||||||||||||||||||||;	
	
Threeofakind:	
		
		;Category is not empty any more
		mov arrayIndex[24],1

		mov sum,0
		mov count,0
		mov ecx,6
		mov ebx,1
		mov eax,0
		
		thrOfKindLoop1:
		
			mov ecx,LENGTHOF arrayRandomDice	
			mov esi,0
			mov eax,0
			
			thrOfKindLoop2:
			
			cmp arrayRandomDice[esi],ebx
			je scoreThreeof
			jne ofscore
scoreThreeof:  add eax,1
ofscore:	   add esi,4	
			cmp eax,2
			jg goScore		
            ;call dumpregs			
			loop thrOfKindLoop2
		
		cmp ebx,6
		je gog
		jne asagi
gog:	cmp count,2
		jle Quit
asagi:		inc ebx
		loop thrOfKindLoop1

		
goScore:
			 mov ecx,LENGTHOF arrayRandomDice
			 mov edi,OFFSET arrayRandomDice
			 mov eax,0
			 goScoreloop:
			 add eax,[edi]
			 add edi,TYPE arrayRandomDice			 
			 loop goScoreloop
			 mov arrayScore[24],eax

	
		jmp Quit

	;|||||||||||||||||||||||||||||||;	
		
Fourofakind:	
		
		;Category is not empty any more
		mov arrayIndex[28],1
		
		mov sum,0
		mov count,0
		mov ecx,6
		mov ebx,1
		mov eax,0
		
		frOfKindLoop1:
		
			mov ecx,LENGTHOF arrayRandomDice	
			mov esi,0
			mov eax,0
			
			frOfKindLoop2:
			
			cmp arrayRandomDice[esi],ebx
			je scoreFourof
			jne ofscorefour
scoreFourof:  add eax,1
ofscorefour:   add esi,4	
			cmp eax,3
			jg goScorefour		
            ;call dumpregs			
			loop frOfKindLoop2
		
		cmp ebx,6
		je gogfour
		jne asagifour
gogfour:	cmp count,3
		jle Quit
asagifour:		inc ebx
		loop frOfKindLoop1

		
goScorefour:	
			 mov ecx,LENGTHOF arrayRandomDice
			 mov edi,OFFSET arrayRandomDice
			 mov eax,0
			 goScoreloopfour:
			 add eax,[edi]
			 add edi,TYPE arrayRandomDice			 
			 loop goScoreloopfour
			 mov arrayScore[28],eax

	
		jmp Quit
		
	;|||||||||||||||||||||||||||||||;	

Yahtzee:	
			;Category is not empty any more
			mov arrayIndex[32],1

			mov ecx,4
			mov esi,0
			
	Case9:  mov eax,arrayRandomDice[esi]
			cmp eax,arrayRandomDice[esi+4]
			jne W
			je T
					
		T:add esi,4
				mov eax,50
				mov arrayScore[32],eax
				loop Case9
				
				push eax
				mov eax,arrayScore[32]
				call WriteDec
				pop eax
				
			jmp Quit
			
			W:	mov eax,0
				mov arrayScore[32],0
			
				push eax
				mov eax,arrayScore[32]
				call WriteDec
				pop eax
			
	
	
				jmp Quit
				
	;|||||||||||||||||||||||||||||||;			
				
				
;Score four in a row	
FourInaRow:

	;Category is not empty any more
	mov arrayIndex[36],1

;Sort array of random dices 
mov ecx,5
shr esi,2  	
mov ecx,esi
push ecx  
dec ecx
	
loopfourrow1:	
	mov esi,0
	push ecx
	
	loopfourrow2:
		mov ebx,arrayRandomDice[esi]
		cmp ebx,arrayRandomDice[esi+4] 
		jle donothingfourrow
		xchg ebx,arrayRandomDice[esi+4]	
		mov arrayRandomDice[esi],ebx

	donothingfourrow:
		add esi,4	
		
		loop loopfourrow2

		pop ecx
	loop loopfourrow1		
pop ecx
	
	
	;Look first elements
	cmp arrayRandomDice[0],1
	jne forfouriki
	je firstfourinarowLoop	
	forfouriki:	cmp arrayRandomDice[0],2
	jne forfouruc
	je secondfourinarowLoop
	forfouruc:	cmp arrayRandomDice[0],3
	jne forfourdort
	je thirdfourinarowLoop
	;Look second elements
	forfourdort: cmp arrayRandomDice[1],1
	jne forfourbes
	je fourthfourinarowLoop
	forfourbes:	 cmp arrayRandomDice[1],2
	jne forfouralti
	je fifthfourinarowLoop
	forfouralti:  cmp arrayRandomDice[1],3
	jne Quit
	je sixthfourinarowLoop
	
;If first element equal 1,compare the others	
	firstfourinarowLoop:	
		cmp arrayRandomDice[4],2
		je birInarow
		jne Quit
				
birInarow:	cmp arrayRandomDice[8],3
		je ikiInarow
		jne Quit
		
ikiInarow:	cmp arrayRandomDice[12],4
		jne Quit
		
		mov arrayScore[40],20
	
;If first element equal 2,compare the others			
	secondfourinarowLoop:	
		cmp arrayRandomDice[4],3		
		je dortInarow
		jne Quit
		
dortInarow:	cmp arrayRandomDice[8],4		
		je besInarow
		jne Quit
		
besInarow:	cmp arrayRandomDice[12],5		
		jne Quit
		
		mov arrayScore[40],20
		
;If first element equal 3,compare the others			
	thirdfourinarowLoop:	
		cmp arrayRandomDice[4],4		
		je altiInarow
		jne Quit
		
altiInarow:	cmp arrayRandomDice[8],5		
		je yediInarow
		jne Quit
		
yediInarow:	cmp arrayRandomDice[12],6		
		jne Quit
		
		mov arrayScore[40],20
		
;If second element equal 1,compare the others			
	fourthfourinarowLoop:	
		cmp arrayRandomDice[8],2		
		je sekiz
		jne Quit
		
sekiz:	cmp arrayRandomDice[12],3		
		je dokuz
		jne Quit
		
dokuz:	cmp arrayRandomDice[16],4		
		jne Quit
		
		mov arrayScore[40],20
		
;If second element equal 2,compare the others			
	fifthfourinarowLoop:	
		cmp arrayRandomDice[8],3		
		je on
		jne Quit
		
on:	cmp arrayRandomDice[12],4		
		je onbir
		jne Quit
		
onbir:	cmp arrayRandomDice[16],5		
		jne Quit
		
		mov arrayScore[40],20

;If second element equal 3,compare the others			
	sixthfourinarowLoop:	
		cmp arrayRandomDice[8],4		
		je oniki
		jne Quit
		
oniki:	cmp arrayRandomDice[12],5		
		je onuc
		jne Quit
		
onuc:	cmp arrayRandomDice[16],6		
		jne Quit
		
		mov arrayScore[40],20
		
		
		
			jmp Quit
			
	;|||||||||||||||||||||||||||||||;		
				
FiveInaRow:

;Category is not empty any more
	mov arrayIndex[40],1

;Sort array of random dices 
mov ecx,5
shr esi,2  	
mov ecx,esi
push ecx  
dec ecx
	
loop1:	
	mov esi,0
	push ecx
	
	loop2:
		mov ebx,arrayRandomDice[esi]
		cmp ebx,arrayRandomDice[esi+4] 
		jle donothing
		xchg ebx,arrayRandomDice[esi+4]	
		mov arrayRandomDice[esi],ebx

	donothing:
		add esi,4	
		
		loop loop2

		pop ecx
	loop loop1	
	
pop ecx		

;Look first elements
	cmp arrayRandomDice[0],1
	jne foriki
	je firstnarowLoop	
foriki:	cmp arrayRandomDice[0],2
	jne Quit
	je secondnarowLoop
	
;If first element equal 1,compare the others	
	firstnarowLoop:	
		cmp arrayRandomDice[4],2
		je bir
		jne Quit
				
bir:	cmp arrayRandomDice[8],3
		je iki
		jne Quit
		
iki:	cmp arrayRandomDice[12],4
		je uc
		jne Quit
		
uc:		cmp arrayRandomDice[16],5
		jne Quit
		
		mov arrayScore[40],30	
		
		

;If first element equal 2,compare the others			
	secondnarowLoop:	
		cmp arrayRandomDice[4],3		
		je dort
		jne Quit
		
dort:	cmp arrayRandomDice[8],4		
		je bes
		jne Quit
		
bes:	cmp arrayRandomDice[12],5		
		je alti
		jne Quit
		
alti:	cmp arrayRandomDice[16],6	
		jne Quit
		
		mov arrayScore[40],30		

	
	jmp Quit
	
;|||||||||||||||||||||||||||||||;	
	
Anything:	mov ecx,LENGTHOF arrayRandomDice
			mov esi,0
			
	Case12: mov eax,arrayRandomDice[esi]
			add sum,eax
			add esi,4
			loop Case12
			mov eax,sum
			mov arrayScore[44],eax
			
	;Category is not empty any more
	mov arrayIndex[44],1
	
	jmp Quit
	
	
Quit: 	
		call tablo
		call Crlf
	
		add lpc,1
		
		cmp lpc,12
		je Flw
		jne Fin
		Flw:
		mov ecx,12
		mov esi,0
		Cntrrl:mov eax,arrayScore[esi]
				add tmp,eax
				add esi,4
				loop Cntrrl
				mov edx,OFFSET totPoint
				call WriteString
				mov eax,tmp
				call WriteDec
				call Crlf
	Fin:
	
		;Clear all variables and registers
		mov eax,0
		mov ebx,0
		mov ecx,0
		mov esi,0
		mov count,0
		mov sum,0
		mov tmp,0
	
		ret
	everything  ENDP
	
;------------------------------------------;	
	
;Metod for printing table
	
tablo PROC 

;-----Print hello screen
mov edx,OFFSET welcome
call WriteString
call Crlf

;-----Print title of table
mov edx,OFFSET tit
call WriteString
call Crlf

;-----Print first row of ready-table
mov edx,OFFSET s1
call WriteString

;*****Print first element of score array
mov eax,arrayScore[0]
call WriteDec
call Crlf


;-----Print second row of ready-table
mov edx,OFFSET s2
call WriteString

;*****Print second element of score array
mov eax,arrayScore[4]
call WriteDec
call Crlf

;-----Print third row of ready-table
mov edx,OFFSET s3
call WriteString

;*****Print third element of score array
mov eax,arrayScore[8]
call WriteDec
call Crlf


;-----Print fourth row of ready-table
mov edx,OFFSET s4
call WriteString

;*****Print fourth element of score array	
mov eax,arrayScore[12]
call WriteDec
call Crlf


;-----Print fifth row of ready-table
mov edx,OFFSET s5
call WriteString

;*****Print fifth element of score array
mov eax,arrayScore[16]
call WriteDec
call Crlf


;-----Print sixth row of ready-table
mov edx,OFFSET s6
call WriteString

;*****Print sixth element of score array
mov eax,arrayScore[20]
call WriteDec
call Crlf


;-----Print seventh row of ready-table
mov edx,OFFSET s7
call WriteString

;*****Print seventh element of score array
mov eax,arrayScore[24]
call WriteDec
call Crlf


;-----Print eighth row of ready-table
mov edx,OFFSET s8
call WriteString

;*****Print eighth element of score array
mov eax,arrayScore[28]
call WriteDec
call Crlf


;-----Print ninth row of ready-table
mov edx,OFFSET s9
call WriteString

;*****Print ninth element of score array
mov eax,arrayScore[32]
call WriteDec
call Crlf


;-----Print tenth row of ready-table
mov edx,OFFSET s10
call WriteString

;*****Print tenth element of score array
mov eax,arrayScore[36]
call WriteDec
call Crlf


;-----Print eleventh row of ready-table
mov edx,OFFSET s11
call WriteString

;*****Print eleventh element of score array
mov eax,arrayScore[40]
call WriteDec
call Crlf


;-----Print twelfth row of ready-table
mov edx,OFFSET s12
call WriteString

;*****Print twelfth element of score array
mov eax,arrayScore[44]
call WriteDec
call Crlf

	ret
	tablo ENDP


	exit
main ENDP
END main