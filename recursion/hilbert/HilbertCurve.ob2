<* +MAIN *>
MODULE HilbertCurve;


IMPORT Draw;

VAR 
  u: INTEGER;
  
(* Forward declarations to enable indirect recursion *)
PROCEDURE ^A(i: INTEGER); 
PROCEDURE ^B(i: INTEGER);
PROCEDURE ^C(i: INTEGER);
PROCEDURE ^D(i: INTEGER);  
  
(* ADenS33_Hilbert *)  
PROCEDURE A(i: INTEGER);
BEGIN
  IF i > 0 THEN
    D(i - 1); Draw.Line(4, u); A(i - 1); Draw.Line(6, u); A(i - 1); Draw.Line(0, u); B(i - 1)
  END
END A;

PROCEDURE B(i: INTEGER);
BEGIN
  IF i > 0 THEN
    C(i - 1); Draw.Line(2, u); B(i - 1); Draw.Line(0, u); B(i - 1); Draw.Line(6, u); A(i - 1)
  END
END B;

PROCEDURE C(i: INTEGER);
BEGIN
  IF i > 0 THEN
    B(i - 1); Draw.Line(0, u); C(i - 1); Draw.Line(2, u); C(i - 1); Draw.Line(4, u); D(i - 1)
  END
END C;

PROCEDURE D(i: INTEGER);
BEGIN
  IF i > 0 THEN
    A(i - 1); Draw.Line(6, u); D(i - 1); Draw.Line(4, u); D(i - 1); Draw.Line(2, u); C(i - 1)
  END
END D;

PROCEDURE Hilbert(n: INTEGER);
CONST 
  SquareSize = 512;
VAR 
  i, x0, y0: INTEGER;
BEGIN
  Draw.Clear;
  x0 := Draw.width DIV 2; y0 := Draw.height DIV 2;
  u := SquareSize; i := 0;
  REPEAT
    INC(i); u := u DIV 2;
    x0 := x0 + (u DIV 2); y0 := y0 + (u DIV 2);
    Draw.Set(x0, y0);
    A(i)
  UNTIL i = n;
END Hilbert;

BEGIN
  Hilbert(5);
END HilbertCurve.
