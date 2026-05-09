;****************************************************************************/
; Author: Matthew Nolan
; Date:05/13/2026
; Revision: 1.0
;
; Description: This program is a Pokemon quiz with 10 questions
;
; Register Usage:
; R0 reserved for I/O
; R1 Not used
; R2 Not used
; R3 Not used
; R4 reserved for the score counter
; R5 reserved for the return value of if the user wants to play again
; R6 reserved for stack pointer
; R7 reserved for returning from subroutine
;****************************************************************************/
    .ORIG x3000
    LD R6, STACK
    JSR PrintMenu
    MAINLOOP
    AND R4, R4, #0 ;set the score counter to 0
    JSR DisplayQuestions
    JSR DisplayScore
    ADD R5, R5, #0
    BRz MAINLOOP
    
    LEA R0, EXITMESSAGE
    TRAP x22
    
    HALT
    
STACK .FILL xFDFF

EXITMESSAGE .STRINGZ "\nThanks for playing!\n"

;****************************************************************************/
; Description: This subroutine prints the menu and requires the
; user to press enter to continue
;
; Register Usage:
; R0 reserved for I/O
; R1 used as temp storage
; R2 Not used
; R3 Not used
; R4 reserved for the counter of correct answers
; R5 Not used
; R6 reserved for stack pointer
; R7 reserved for returning from subroutine
;****************************************************************************/
PrintMenu:

    ADD R6, R6, #-1 ;put R1 on stack
    STR R1, R6, #0
    
    LEA R0, MENU    ;load the menu message
    TRAP x22        ;display it
    LEA R0, PIKACHU ;load the pikachu ASCII art
    TRAP x22        ;display it
    LEA R0, HOWTOPLAY ;load the howtoplay message
    TRAP x22        ; display it
    
    MLOOP           ;start the loop here
    TRAP x20        ;get a character from the user
    TRAP x21        ;echo that character
    
    ADD R1, R0, #-10    ;subtract 10 from the character
    
    BRz MDONE       ;if the character was a newline character (enter), the loop is done
    
    BR MLOOP        ;if not, go back to the beginning of the loop and get a new character from the user
                    ;loops until user enters a newline character
    MDONE
    
    LDR R1, R6, #0
    ADD R6, R6, #1 ;restore register from stack
    
    RET

MENU .STRINGZ "Welcome to the Pokémon quiz!"
HOWTOPLAY .STRINGZ "To play, enter the key of the answer you would like to select (Uppercase and lowercase is permitted). \nPress enter to begin: "
PIKACHU .STRINGZ "\n /\       /\    \n |_\     /_|\n |  \___/  |    \n /         \    \n/  O     O  \   \n|()   .   ()|   \n \_   o   _/    \n"

;****************************************************************************/
; Description: This subroutine displays the questions of the quiz
; and uses other subroutines to get the users answer and check their answers
;
; Register Usage:
; R0 reserved for I/O
; R1 used to store the answer from the user
; R2 used to store the correct answer for each question
; R3 Not used
; R4 reserved for the counter of correct answers
; R5 Not used
; R6 reserved for stack pointer
; R7 reserved for returning from subroutine
;****************************************************************************/
DisplayQuestions:

    ADD R6, R6, #-1 ;put R2 on stack
    STR R2, R6, #0
    ADD R6, R6, #-1 ;put R7 on stack
    STR R7, R6, #0

    LD R0, QUESTIONPTR1 ;load question 1 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERB      ;set the correct answer to B
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR2 ;load question 2 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERA      ;set the correct answer to A
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR3 ;load question 3 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERA      ;set the correct answer to A
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR4 ;load question 4 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERC      ;set the correct answer to C
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR5 ;load question 5 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERB      ;set the correct answer to B
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR6 ;load question 6 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERC      ;set the correct answer to C
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR7 ;load question 7 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERC      ;set the correct answer to C
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR8 ;load question 8 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERA      ;set the correct answer to A
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR9 ;load question 9 into R0
    TRAP x22            ;display the question
    LD R2, ANSWERA      ;set the correct answer to A
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LD R0, QUESTIONPTR10 ;load question 10 into R0
    TRAP x22             ;display the question
    LD R2, ANSWERB      ;set the correct answer to B
    JSR GetAnswer       ;get the answer from the user
    JSR CheckAnswer     ;check the user's answer
    
    LDR R7, R6, #0
    ADD R6, R6, #1 
    LDR R2, R6, #0
    ADD R6, R6, #1 ;restore registers from stack
    
    RET
    
ANSWERA .FILL #65
ANSWERB .FILL #66
ANSWERC .FILL #67

;pointers to each question (the strings are too big to access directly)
QUESTIONPTR1 .FILL QUESTION1
QUESTIONPTR2 .FILL QUESTION2
QUESTIONPTR3 .FILL QUESTION3
QUESTIONPTR4 .FILL QUESTION4
QUESTIONPTR5 .FILL QUESTION5
QUESTIONPTR6 .FILL QUESTION6
QUESTIONPTR7 .FILL QUESTION7
QUESTIONPTR8 .FILL QUESTION8
QUESTIONPTR9 .FILL QUESTION9
QUESTIONPTR10 .FILL QUESTION10

;****************************************************************************/
; Description: This subroutine gets the answer from the user
;
; Register Usage:
; R0 reserved for I/O
; R1 stores the users answer
; R2 Not used
; R3 Not used
; R4 reserved the counter of correct answers
; R5 Not used
; R6 reserved for stack pointer
; R7 reserved for returning from subroutine
;****************************************************************************/
GetAnswer: 

    ADD R6, R6, #-1 ;put R7 on stack
    STR R7, R6, #0
    
    LEA R0, PROMPT  ;load the prompt message
    TRAP x22        ;display it
    TRAP x20        ;get a character from the user
    TRAP x21        ;echo that character
    ADD R1, R0, #0  ;store that character in R1
    
    LEA R0, NEWLINE ;display a newline character
    TRAP x22
    
    LDR R7, R6, #0
    ADD R6, R6, #1 ;restore R7
    
    RET
    
PROMPT .STRINGZ "\nEnter your answer: "
NEWLINE .STRINGZ "\n"

;****************************************************************************/
; Description: This subroutine checks what the correct answer is,
; and then adds 1 to the score if the users answer is correct
;
; Note: R2 should contain the ASCII representation of A, B, or C
;
; Register Usage:
; R0 reserved for I/O
; R1 stores the users answer
; R2 stores the correct answer
; R3 used as temp storage, and to store 97, 98, 99
; R4 is the counter of correct answers
; R5 stores the numbers 65, 66, and 67
; R6 reserved for stack pointer
; R7 reserved for returning from subroutine
;****************************************************************************/
CheckAnswer:

    ADD R6, R6, #-1 ;put R5 on stack
    STR R5, R6, #0
    ADD R6, R6, #-1 ;put R3 on stack
    STR R3, R6, #0

    LD R5, NUMNEG65
    ;check if the correct answer is A by subtracting 65
    ADD R3, R2, R5
    BRz CORRECTA
    ;check if the correct answer is B by subtracting 66
    ADD R5, R5, #-1
    ADD R3, R2, R5
    BRz CORRECTB
    ;check if the correct answer is C by subtracting 67
    ADD R5, R5, #-1
    ADD R3, R2, R5
    BRz CORRECTC
    
    BR CDONE ;stop the subroutine if one is not selected (shouldn't happen)
    
    ;if the correct answer is A..
    CORRECTA
    
    ADD R3, R1, R5 ;subtract 65 from R1, if it's 0, then the user input A
    BRz COUNTERPLUS
    
    LD R3, NUMNEG97
    ADD R3, R1, R3
    BRz COUNTERPLUS ;subtract 97 from R1, if it's 0, then the user input a
    
    BR CDONE
    
    ;if the correct answer is B..
    CORRECTB
    
    ADD R3, R1, R5 ;subtract 66 from R1, if it's 0, then the user input B
    BRz COUNTERPLUS
    
    LD R3, NUMNEG97
    ADD R3, R3, #-1
    ADD R3, R1, R3
    BRz COUNTERPLUS ;subtract 98 from R1, if it's 0, then the user input b
    
    BR CDONE
    
    ;if the correct answer is C..
    CORRECTC
    
    ADD R3, R1, R5 ;subtract 67 from R1, if it's 0, then the user input C
    BRz COUNTERPLUS
    
    LD R3, NUMNEG97
    ADD R3, R3, #-2
    ADD R3, R1, R3
    BRz COUNTERPLUS ;subtract 99 from R1, if it's 0, then the user input c
    
    BR CDONE
    
    COUNTERPLUS
    
    ADD R4, R4 #1 ;add one to the counter if the user input the correct answer
    
    CDONE
    
    LDR R3, R6, #0
    ADD R6, R6, #1
    LDR R5, R6, #0
    ADD R6, R6, #1 ;restore registers from stack
    
    RET
    
NUMNEG65 .FILL #-65
NUMNEG97 .FILL #-97
;****************************************************************************/
; Description: This subroutine displays the score, displays a message
; based on the users score, and asks if the user wants to play again
;
; Register Usage:
; R0 reserved for I/O
; R1 Not used
; R2 Not used
; R3 used for temp storage
; R4 used for the counter of correct answers
; R5 used as temp storage, and then return value for if player wants to play again (0 if yes)
; R6 reserved for stack pointer
; R7 reserved for returning from subroutine
;****************************************************************************/
DisplayScore:
    
    ADD R6, R6, #-1 ;put R3 on stack
    STR R3, R6, #0
    
    LEA R0, SCOREMESSAGE1 ;load and display the first part of the score message
    TRAP x22
    
    ADD R5, R4, #-10
    BRz TEN             ;check if the score was 10
    
    LD R3, ASCII        ;if not ten, 
    ADD R0, R4, R3      ;display the number
    TRAP x21
    
    BR NOTTEN
    
    TEN             ;if the score was 10, display 10 through a string
    LEA R0, NUMTEN
    TRAP X22
    
    NOTTEN
    LEA R0, SCOREMESSAGE2 ;now display the last part of the message ("/10")
    TRAP x22
    
    ADD R5, R4, #-3     ;check if the user got 3 or less right
    BRnz BAD            
    
    ADD R5, R4, #-6     ;check if the user got 6 or less right
    BRnz OK
    
    ADD R5, R4, #-6     ;check if the user got 7 or more right
    BRp GOOD
    
    BAD
    LEA R0, BADMESSAGE ;if they got 3 or less right, display the bad message
    TRAP x22
    
    BR SDONE
    
    OK 
    LEA R0, OKMESSAGE ;if they got 6 or less  (but more than 3) right, display the OK message
    TRAP x22
    
    BR SDONE
    
    GOOD
    LEA R0, GOODMESSAGE ;if they got 7 or more right, display the good message
    TRAP x22
    
    SDONE
    
    LEA R0 PLAYAGAIN ;load and display the play again message
    TRAP x22
    TRAP x20        ;get a character from the user
    LD R5, SPACE        
    ADD R5, R0, R5  
    BRz YESAGAIN    
    
    BR NOAGAIN
    
    YESAGAIN
    AND R5, R5, #0 ;if the character is a space, return 0
    
    BR ADONE
 
    NOAGAIN ;if the character is anything else, return 1
    AND R5, R5, #0
    ADD R5, R5, #1
    
    ADONE
    
    LDR R3, R6, #0
    ADD R6, R6, #1 ;restore registers
    
    RET
    
SCOREMESSAGE1 .STRINGZ "\nYour score: "
SCOREMESSAGE2 .STRINGZ "/10"
BADMESSAGE .STRINGZ "\nLooks like you need some more practice..\n"
OKMESSAGE .STRINGZ "\nYou did pretty alright!\n"
GOODMESSAGE .STRINGZ "\nGreat job!\n"
PLAYAGAIN .STRINGZ "Would you like to play again? \nPress SPACE to play again, press anything else to quit. "
NUMTEN .STRINGZ "10"
SPACE .FILL #-32
ASCII .FILL #48

;the questions
QUESTION1 .STRINGZ "\nQuestion 1: \nWhich Pokémon is #1 in the Pokédex? \nA) Charizard \nB) Bulbasaur \nC) Pikachu"
QUESTION2 .STRINGZ "\nQuestion 2: \nWhat type of Pokémon is Eevee? \nA) Normal \nB) Grass \nC) Fairy"
QUESTION3 .STRINGZ "\nQuestion 3: \nWhich type of Pokéball will always catch without fail? \nA) Master Ball \nB) Ultra Ball \nC) Great Ball"
QUESTION4 .STRINGZ "\nQuestion 4: \nHow many different types of Pokémon are there? \nA) 20 \nB) 15 \nC) 18"
QUESTION5 .STRINGZ "\nQuestion 5: \nWhich types are starter Pokémon, generally? \nA) Water, Fire, Ground \nB) Water, Fire, Grass \nC) Fire, Ice, Electric"
QUESTION6 .STRINGZ "\nQuestion 6: \nWhich type of Pokémon are immune to Fighting type? \nA) Dragon \nB) Steel \nC) Ghost"
QUESTION7 .STRINGZ "\nQuestion 7: \nHow many evolutions does the Pokémon Eevee have? \nA) 5 \nB) 10 \nC) 9"
QUESTION8 .STRINGZ "\nQuestion 8: \nWhich type of Pokémon are immune to Dragon type? \nA) Fairy \nB) Fire \nC) Ground"
QUESTION9 .STRINGZ "\nQuestion 9: \nWhat is the most recent Pokémon type added to the games? \nA) Fairy \nB) Dragon \nC) Steel"
QUESTION10 .STRINGZ "\nQuestion 10: \nWhat is Matthew's favorite Pokémon right now? \nA) Sylveon \nB) Houndoom \nC) Slowpoke"

        .END