!! SYMFILE #StableMarriages 0x00030007 #StableMarriages.%main 1
!! CONST #n INTCONST 8
!! TYPE #woman INTEGER
!! TYPE #man INTEGER
!! TYPE #rank INTEGER
!! GLOBAL #wmr #StableMarriages.wmr !0 ARRAY 8 !1 ARRAY 8 INTEGER
!! GLOBAL #mwr #StableMarriages.mwr !2 ARRAY 8 !3 ARRAY 8 INTEGER
!! GLOBAL #x #StableMarriages.x !4 ARRAY 8 INTEGER
!! GLOBAL #y #StableMarriages.y 4
!! GLOBAL #single #StableMarriages.single !5 ARRAY 8 BOOLEAN
!! GLOBAL #rmw #StableMarriages.rmw !6 ARRAY 8 !7 ARRAY 8 INTEGER
!! GLOBAL #rwm #StableMarriages.rwm !8 ARRAY 8 !9 ARRAY 8 INTEGER
!! PROCEDURE #write 18 #StableMarriages.write !10 PROC 0 VOID;
!!     LOCAL #m -4 INTEGER
!!     LOCAL #rm -8 INTEGER
!!     LOCAL #rw -12 INTEGER;
!! PROCEDURE #stable 29 #StableMarriages.stable !11 PROC 3 BOOLEAN
!!   PARAM #m 12 INTEGER
!!   PARAM #w 16 INTEGER
!!   PARAM #r 20 INTEGER;
!!     LOCAL #pm -4 INTEGER
!!     LOCAL #pw -8 INTEGER
!!     LOCAL #rank -12 INTEGER
!!     LOCAL #i -16 INTEGER
!!     LOCAL #lim -20 INTEGER
!!     LOCAL #S -21 BOOLEAN;
!! PROCEDURE #Try 58 #StableMarriages.Try !12 PROC 1 VOID
!!   PARAM #m 12 INTEGER;
!!     LOCAL #w -4 INTEGER
!!     LOCAL #r -8 INTEGER;
!! PROCEDURE #FindStableMarriages 75 #StableMarriages.FindStableMarriages !13 PROC 0 VOID;
!!     LOCAL #m -4 INTEGER
!!     LOCAL #w -8 INTEGER
!!     LOCAL #r -12 INTEGER;
!! END 0x60a62d91
!! 
MODULE StableMarriages 0x60a62d91 99
IMPORT In 0x5fa6adc2
IMPORT Out 0x7e32f5d9
ENDHDR

PROC StableMarriages.write 12 5 0
! PROCEDURE write;
LINE 18
!     rm := 0; rw := 0;
LINE 21
CONST 0
STLW -8
CONST 0
STLW -12
!     FOR m := 0 TO n-1 DO
LINE 22
CONST 0
STLW -4
LABEL L6
LDLW -4
CONST 7
JGT L7
!         Out.Int(x[m], 4);
LINE 23
CONST 4
GLOBAL StableMarriages.x
LDLW -4
CONST 8
BOUND 23
LDIW
GLOBAL Out.Int
CALL 2
!         rm := rmw[m, x[m]] + rm; rw := rwm[x[m], m] + rw
LINE 24
GLOBAL StableMarriages.rmw
LDLW -4
CONST 8
BOUND 24
CONST 8
TIMES
GLOBAL StableMarriages.x
LDLW -4
CONST 8
BOUND 24
LDIW
CONST 8
BOUND 24
PLUS
LDIW
LDLW -8
PLUS
STLW -8
GLOBAL StableMarriages.rwm
GLOBAL StableMarriages.x
LDLW -4
CONST 8
BOUND 24
LDIW
CONST 8
BOUND 24
CONST 8
TIMES
LDLW -4
CONST 8
BOUND 24
PLUS
LDIW
LDLW -12
PLUS
STLW -12
!     FOR m := 0 TO n-1 DO
LINE 22
INCL -4
JUMP L6
LABEL L7
!     Out.Int(rm, 8); Out.Int(rw, 4); Out.Ln()
LINE 26
CONST 8
LDLW -8
GLOBAL Out.Int
CALL 2
CONST 4
LDLW -12
GLOBAL Out.Int
CALL 2
GLOBAL Out.Ln
CALL 0
RETURN
END

PROC StableMarriages.stable 24 6 0
! PROCEDURE stable (m, w, r: INTEGER): BOOLEAN;
LINE 29
!     i := -1; S := TRUE;
LINE 33
CONST -1
STLW -16
CONST 1
STLC -21
LABEL L8
!         INC(i);
LINE 35
INCL -16
!         IF i < r THEN
LINE 36
LDLW -16
LDLW 20
JGEQ L13
!             pw := wmr[m,i];
LINE 37
GLOBAL StableMarriages.wmr
LDLW 12
CONST 8
BOUND 37
CONST 8
TIMES
LDLW -16
CONST 8
BOUND 37
PLUS
LDIW
STLW -8
!             IF ~single[pw] THEN
LINE 38
GLOBAL StableMarriages.single
LDLW -8
CONST 8
BOUND 38
LDIC
JNEQZ L13
!                 S := rwm[pw,m] > rwm[pw, y[pw]]
LINE 39
GLOBAL StableMarriages.rwm
LDLW -8
CONST 8
BOUND 39
CONST 8
TIMES
LDLW 12
CONST 8
BOUND 39
PLUS
LDIW
GLOBAL StableMarriages.rwm
LDLW -8
CONST 8
BOUND 39
CONST 8
TIMES
GLOBAL StableMarriages.y
LDLW -8
CONST 8
BOUND 39
LDIW
CONST 8
BOUND 39
PLUS
LDIW
GT
STLC -21
LABEL L13
!     UNTIL (i = r) OR ~S;
LINE 42
LDLW -16
LDLW 20
JEQ L9
LDLC -21
JNEQZ L8
LABEL L9
!     i := -1; lim := rwm[w,m];
LINE 44
CONST -1
STLW -16
GLOBAL StableMarriages.rwm
LDLW 16
CONST 8
BOUND 44
CONST 8
TIMES
LDLW 12
CONST 8
BOUND 44
PLUS
LDIW
STLW -20
LABEL L17
!         INC(i);
LINE 46
INCL -16
!         IF i < lim THEN
LINE 47
LDLW -16
LDLW -20
JGEQ L22
!             pm := mwr[w,i];
LINE 48
GLOBAL StableMarriages.mwr
LDLW 16
CONST 8
BOUND 48
CONST 8
TIMES
LDLW -16
CONST 8
BOUND 48
PLUS
LDIW
STLW -4
!             IF pm < m THEN
LINE 49
LDLW -4
LDLW 12
JGEQ L22
!                 S := rmw[pm,w] > rmw[pm, x[pm]]
LINE 50
GLOBAL StableMarriages.rmw
LDLW -4
CONST 8
BOUND 50
CONST 8
TIMES
LDLW 16
CONST 8
BOUND 50
PLUS
LDIW
GLOBAL StableMarriages.rmw
LDLW -4
CONST 8
BOUND 50
CONST 8
TIMES
GLOBAL StableMarriages.x
LDLW -4
CONST 8
BOUND 50
LDIW
CONST 8
BOUND 50
PLUS
LDIW
GT
STLC -21
LABEL L22
!     UNTIL (i = lim) OR ~S;
LINE 53
LDLW -16
LDLW -20
JEQ L18
LDLC -21
JNEQZ L17
LABEL L18
!     RETURN S
LINE 55
LDLC -21
RETURNW
END

PROC StableMarriages.Try 8 6 0
! PROCEDURE Try (m: INTEGER);
LINE 58
!     IF m < n THEN
LINE 61
LDLW 12
CONST 8
JGEQ L28
!         FOR r := 0 TO n-1 DO
LINE 62
CONST 0
STLW -8
LABEL L29
LDLW -8
CONST 7
JGT L26
!             w := wmr[m,r];
LINE 63
GLOBAL StableMarriages.wmr
LDLW 12
CONST 8
BOUND 63
CONST 8
TIMES
LDLW -8
CONST 8
BOUND 63
PLUS
LDIW
STLW -4
!             IF single[w] & stable(m,w,r) THEN
LINE 64
GLOBAL StableMarriages.single
LDLW -4
CONST 8
BOUND 64
LDIC
JEQZ L33
LDLW -8
LDLW -4
LDLW 12
GLOBAL StableMarriages.stable
CALLW 3
JEQZ L33
!                 x[m] := w; y[w] := m; single[w] := FALSE;
LINE 65
LDLW -4
GLOBAL StableMarriages.x
LDLW 12
CONST 8
BOUND 65
STIW
LDLW 12
GLOBAL StableMarriages.y
LDLW -4
CONST 8
BOUND 65
STIW
CONST 0
GLOBAL StableMarriages.single
LDLW -4
CONST 8
BOUND 65
STIC
!                 Try(m+1);
LINE 66
LDLW 12
INC
GLOBAL StableMarriages.Try
CALL 1
!                 single[w] := TRUE
LINE 67
CONST 1
GLOBAL StableMarriages.single
LDLW -4
CONST 8
BOUND 67
STIC
LABEL L33
!         FOR r := 0 TO n-1 DO
LINE 62
INCL -8
JUMP L29
LABEL L28
!         write
LINE 71
GLOBAL StableMarriages.write
CALL 0
LABEL L26
RETURN
END

PROC StableMarriages.FindStableMarriages 12 7 0
! PROCEDURE FindStableMarriages;
LINE 75
!     Out.String("Enter men ranks:"); Out.Ln();
LINE 78
CONST 17
GLOBAL StableMarriages.%1
GLOBAL Out.String
CALL 2
GLOBAL Out.Ln
CALL 0
!     FOR m := 0 TO n-1 DO
LINE 79
CONST 0
STLW -4
LABEL L35
LDLW -4
CONST 7
JGT L36
!         FOR r := 0 TO n-1 DO
LINE 80
CONST 0
STLW -12
LABEL L37
LDLW -12
CONST 7
JGT L38
!             Out.String("["); Out.Int(m, 0); Out.String(", "); Out.Int(r, 0); Out.String("] = ");
LINE 81
CONST 2
GLOBAL StableMarriages.%5
GLOBAL Out.String
CALL 2
CONST 0
LDLW -4
GLOBAL Out.Int
CALL 2
CONST 3
GLOBAL StableMarriages.%2
GLOBAL Out.String
CALL 2
CONST 0
LDLW -12
GLOBAL Out.Int
CALL 2
CONST 5
GLOBAL StableMarriages.%3
GLOBAL Out.String
CALL 2
!             In.Int(wmr[m,r]); rmw[m, wmr[m,r]] := r
LINE 82
GLOBAL StableMarriages.wmr
LDLW -4
CONST 8
BOUND 82
CONST 8
TIMES
LDLW -12
CONST 8
BOUND 82
PLUS
INDEXW
GLOBAL In.Int
CALL 1
LDLW -12
GLOBAL StableMarriages.rmw
LDLW -4
CONST 8
BOUND 82
CONST 8
TIMES
GLOBAL StableMarriages.wmr
LDLW -4
CONST 8
BOUND 82
CONST 8
TIMES
LDLW -12
CONST 8
BOUND 82
PLUS
LDIW
CONST 8
BOUND 82
PLUS
STIW
!         FOR r := 0 TO n-1 DO
LINE 80
INCL -12
JUMP L37
LABEL L38
!     FOR m := 0 TO n-1 DO
LINE 79
INCL -4
JUMP L35
LABEL L36
!     Out.String("Enter women ranks:"); Out.Ln();
LINE 86
CONST 19
GLOBAL StableMarriages.%4
GLOBAL Out.String
CALL 2
GLOBAL Out.Ln
CALL 0
!     FOR w := 0 TO n-1 DO
LINE 87
CONST 0
STLW -8
LABEL L39
LDLW -8
CONST 7
JGT L40
!         single[w] := TRUE;
LINE 88
CONST 1
GLOBAL StableMarriages.single
LDLW -8
CONST 8
BOUND 88
STIC
!         FOR r := 0 TO n-1 DO
LINE 89
CONST 0
STLW -12
LABEL L41
LDLW -12
CONST 7
JGT L42
!             Out.String("["); Out.Int(w, 0); Out.String(", "); Out.Int(r, 0); Out.String("] = ");
LINE 90
CONST 2
GLOBAL StableMarriages.%5
GLOBAL Out.String
CALL 2
CONST 0
LDLW -8
GLOBAL Out.Int
CALL 2
CONST 3
GLOBAL StableMarriages.%2
GLOBAL Out.String
CALL 2
CONST 0
LDLW -12
GLOBAL Out.Int
CALL 2
CONST 5
GLOBAL StableMarriages.%3
GLOBAL Out.String
CALL 2
!             In.Int(mwr[w,r]); rwm[w, mwr[w,r]] := r
LINE 91
GLOBAL StableMarriages.mwr
LDLW -8
CONST 8
BOUND 91
CONST 8
TIMES
LDLW -12
CONST 8
BOUND 91
PLUS
INDEXW
GLOBAL In.Int
CALL 1
LDLW -12
GLOBAL StableMarriages.rwm
LDLW -8
CONST 8
BOUND 91
CONST 8
TIMES
GLOBAL StableMarriages.mwr
LDLW -8
CONST 8
BOUND 91
CONST 8
TIMES
LDLW -12
CONST 8
BOUND 91
PLUS
LDIW
CONST 8
BOUND 91
PLUS
STIW
!         FOR r := 0 TO n-1 DO
LINE 89
INCL -12
JUMP L41
LABEL L42
!     FOR w := 0 TO n-1 DO
LINE 87
INCL -8
JUMP L39
LABEL L40
!     Try(0)
LINE 94
CONST 0
GLOBAL StableMarriages.Try
CALL 1
RETURN
END

PROC StableMarriages.%main 0 7 0
!     FindStableMarriages;
LINE 98
GLOBAL StableMarriages.FindStableMarriages
CALL 0
RETURN
END

! Global variables
GLOVAR StableMarriages.wmr 256
GLOVAR StableMarriages.mwr 256
GLOVAR StableMarriages.x 32
GLOVAR StableMarriages.y 32
GLOVAR StableMarriages.single 8
GLOVAR StableMarriages.rmw 256
GLOVAR StableMarriages.rwm 256

! String "Enter men ranks:"
DEFINE StableMarriages.%1
STRING 456E746572206D656E2072616E6B733A00

! String ", "
DEFINE StableMarriages.%2
STRING 2C2000

! String "] = "
DEFINE StableMarriages.%3
STRING 5D203D2000

! String "Enter women ranks:"
DEFINE StableMarriages.%4
STRING 456E74657220776F6D656E2072616E6B733A00

! String "["
DEFINE StableMarriages.%5
STRING 5B00

! End of file
