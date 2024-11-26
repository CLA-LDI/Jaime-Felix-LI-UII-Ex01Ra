					TITLE	Programa para determinar si una cadena inicia con un prefijo

; Prototipos de llamadas al sistema operativo
GetStdHandle	PROTO	:QWORD
ReadConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
WriteConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
ExitProcess		PROTO	CodigoSalida:QWORD

				.DATA
Cadena			WORD	80 DUP ( ? )
Prefijo			WORD	80 DUP ( ? )
LongCadena		QWORD	?
LongPrefijo		QWORD	?
MenEnt01		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'l', 'a', ' ', 'c', 'a', 'd', 'e', 'n', 'a', ' ', ':', ' '
MenEnt02		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'e', 'l', ' ', 'p', 'r', 'e', 'f', 'i', 'j', 'o', ':', ' '
; Definir los mensajes de salida correspondientes

; Variables utilizadas por las llamadas al sistema
ManejadorE		QWORD	?
ManejadorS		QWORD	?
Caracteres		QWORD	?
SaltoLinea		WORD	13, 10
STD_INPUT		EQU		-10
STD_OUTPUT		EQU		-11

				.CODE
Principal		PROC

				; Alinear espacio en la pila
				SUB		RSP, 40

				; Obtener manejador est�ndar del teclado
				MOV		RCX, STD_INPUT
				CALL	GetStdHandle
				MOV		ManejadorE, RAX

				; Obtener manejador est�ndar de la consola
				MOV		RCX, STD_OUTPUT
				CALL	GetStdHandle
				MOV		ManejadorS, RAX

				; Solicitar la cadena
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, MenEnt01				; Direcci�n de la cadena a escribir
				MOV		R8, LENGTHOF MenEnt01		; N�mero de caracteres a escribir
				LEA		R9, Caracteres				; Direcci�n de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				MOV		RCX, ManejadorE				; Manejador del teclado donde se lee la cadena
				LEA		RDX, Cadena					; Direcci�n de la cadena a leer
				MOV		R8, LENGTHOF Cadena			; N�mero de caracteres m�ximo a leer
				LEA		R9, LongCadena				; Direcci�n de la variable donde se guarda el total de caracteres le�dos
				MOV		R10, 0						; Reservado para uso futuro
				CALL	ReadConsoleW

				SUB		LongCadena, 2					; Para eliminar el <Enter>

				; Solicitar el prefijo

				; Debe comparar la cadena y el prefijo hasta la longitud del prefijo.
				; Si son iguales entonces la cadena inicia con el prefijo

				; Mostrar el resultado correspondiente:
				; La cadena inicia con el prefijo
				; La cadena no inicia con el prefijo

				; Salto de l�nea
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, SaltoLinea				; Direcci�n de la cadena a escribir
				MOV		R8, LENGTHOF SaltoLinea		; N�mero de caracteres a escribir
				LEA		R9, Caracteres				; Direcci�n de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				; Salir al sistema operativo
				MOV		RCX, 0
				CALL	ExitProcess

Principal		ENDP
				END