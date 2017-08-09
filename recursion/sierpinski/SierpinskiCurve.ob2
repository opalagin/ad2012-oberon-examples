<* +MAIN *>
MODULE SierpinskiCurve;

IMPORT Draw;

VAR 
  h: INTEGER;
  
(* Forward declarations for indirect recursion *)
PROCEDURE ^A(k: INTEGER); 
PROCEDURE ^B(k: INTEGER);
PROCEDURE ^C(k: INTEGER);
PROCEDURE ^D(k: INTEGER);
  
PROCEDURE A(k: INTEGER);
BEGIN
  IF k > 0 THEN
    A(k - 1); Draw.Line(7, h); B(k - 1); Draw.Line(0, 2 * h);
    D(k - 1); Draw.Line(1, h); A(k - 1)
  END
END A;

PROCEDURE B(k: INTEGER);
BEGIN
  IF k > 0 THEN
    B(k - 1); Draw.Line(5, h); C(k - 1); Draw.Line(6, 2 * h);
    A(k - 1); Draw.Line(7, h); B(k - 1)
  END
END B;

PROCEDURE C(k: INTEGER);
BEGIN
  IF k > 0 THEN
    C(k - 1); Draw.Line(3, h); D(k - 1); Draw.Line(4, 2 * h);
    B(k - 1); Draw.Line(5, h); C(k - 1)
  END
END C;

PROCEDURE D(k: INTEGER);
BEGIN
  IF k > 0 THEN
    D(k - 1); Draw.Line(1, h); A(k - 1); Draw.Line(2, 2 * h);
    C(k - 1); Draw.Line(3, h); D(k - 1)
  END
END D;

PROCEDURE Sierpinski(n: INTEGER);
CONST 
  SquareSize = 512;
VAR 
  i, x0, y0: INTEGER;
BEGIN
  Draw.Clear;
  h := SquareSize DIV 4;
  x0 := Draw.width DIV 2; y0 := Draw.height DIV 2 + h;
  i := 0;
  REPEAT
    INC(i); x0 := x0 - h;
    h := h DIV 2; y0 := y0 + h; Draw.Set(x0, y0);
    A(i); Draw.Line(7, h); B(i); Draw.Line(5, h);
    C(i); Draw.Line(3, h); D(i); Draw.Line(1, h)
  UNTIL i = n
END Sierpinski;

BEGIN
  Sierpinski(4);
END SierpinskiCurve.
