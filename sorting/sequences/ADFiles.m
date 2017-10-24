MODULE ADFiles;

IMPORT Out;

CONST 
  MaxLength = 4096;
  
TYPE 
  File* = POINTER TO RECORD
    len: INTEGER;
    a: ARRAY MaxLength OF CHAR
  END;
  
  Rider* = RECORD 
  (* 0 <= pos <= f.len <= Max Length *)
    f: File; pos: INTEGER; eof*: BOOLEAN
  END;
  
PROCEDURE New*(name: ARRAY OF CHAR): File;
VAR 
  f: File;
BEGIN 
  NEW(f); f.len := 0; (*directory operation omitted*)
  RETURN f
END New;

PROCEDURE Old*(name: ARRAY OF CHAR): File;
VAR 
  f: File;
BEGIN 
  NEW(f); (*directory lookup omitted*)
  RETURN f
END Old;

PROCEDURE Close*(VAR f: File);
BEGIN
END Close;

PROCEDURE Set*(VAR r: Rider; f: File; pos: INTEGER);
BEGIN 
(*assume f # NIL*) r.f := f; r.eof := FALSE;
  IF pos >= 0 THEN
    IF pos <= f.len THEN 
      r.pos := pos 
    ELSE 
      r.pos := f.len 
    END
  ELSE
    r.pos := 0
  END
END Set;

PROCEDURE Write*(VAR r: Rider; ch: CHAR);
BEGIN
  IF (r.pos <= r.f.len) & (r.pos < MaxLength) THEN
    r.f.a[r.pos] := ch; INC(r.pos);
    IF r.pos > r.f.len THEN 
      INC(r.f.len)
    END
  ELSE
    r.eof := TRUE
  END
END Write;

PROCEDURE Read*(VAR r: Rider; VAR ch: CHAR);
BEGIN
  IF r.pos < r.f.len THEN
    ch := r.f.a[r.pos]; INC(r.pos)
  ELSE
    r.eof := TRUE
  END
END Read;

(* Writes integer as text *)
PROCEDURE WriteInt*(VAR r: Rider; n: INTEGER);
VAR 
  ch: CHAR;
  a: ARRAY 255 OF CHAR;
  q, rem, i: INTEGER;
BEGIN 
  (* convert into chars *)
  i := 0;
  q := n;
  REPEAT
    rem := q MOD 10;
    a[i] := CHR(ORD('0') + rem);
    INC(i);
    q := q DIV 10;
  UNTIL q = 0;
  (* output chars to the file *)
  WHILE (i > 0) & (~r.eof) DO
    DEC(i);
    Write(r, a[i]);
  END;
  (* end of string *)
  Write(r, CHR(0));
END WriteInt;

(* Reads integer back from text *)
PROCEDURE ReadInt*(VAR r: Rider; VAR n: INTEGER);
VAR 
  ch: CHAR;
BEGIN 
  n := 0;
  (* read string of digits *)
  Read(r, ch);
  WHILE (ch >= '0') & (ch <= '9') & (~r.eof) DO
    n := n * 10 + (ORD(ch) - ORD('0')); 
    Read(r, ch); 
  END;
END ReadInt;

BEGIN
END ADFiles.
