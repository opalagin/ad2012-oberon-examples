MODULE Draw;

IMPORT MathL, Out, VTerm;

CONST width* = 800; height* = 640;
  
VAR penX, penY: LONGINT;
    
  
(*clear drawing plane*)
PROCEDURE Clear*;
BEGIN
  VTerm.ClearScreen(0);
END Clear;

PROCEDURE Set*(x, y: INTEGER);
BEGIN
  penX := x;
  penY := y;
END Set;

(*draw line of length len in direction dir*45 degrees; move pen accordingly*)
PROCEDURE Line*(dir, len: INTEGER);
VAR 
  angle, sign, dx, dy: LONGINT;
BEGIN
  (* NOTE: I couldn't get enough precision by using direct formulas
           so I had to use angle property plus hard code common cases *)
  angle := dir * 45; 
  
  dx := 1; dy := 1;
  IF (angle >= 90) & (angle <= 180) THEN
    dx := -1; dy := 1;
  ELSIF (angle > 180) & (angle < 270) THEN
    dx := -1; dy := -1;
  ELSIF angle >= 270 THEN
    dx := 1; dy := -1;
  END;
  
  IF angle > 180 THEN angle := angle - 180;
  ELSIF angle > 90 THEN angle := 180 - angle END;
  
  IF angle = 0 THEN 
    dx := dx * len; dy := 0;
  ELSIF angle = 90 THEN 
    dx := 0; dy := dy * len;
  ELSE
    dx := dx * ENTIER(len * MathL.cos(angle * (MathL.pi / 180))); 
    dy := dy * ENTIER(len * MathL.sin(angle * (MathL.pi / 180)));
  END;
  
  VTerm.Line(penX, penY, penX + dx, penY + dy, VTerm._clrBRIGHTWHITE);
  
  penX := penX + dx;
  penY := penY + dy;
END Line;

BEGIN
  IF ~VTerm.Init(0, 0, width, height, 200) THEN HALT END;
  VTerm.InitStdPalette;
  VTerm.ClearScreen(0);
  penX := 0; penY := 0;
END Draw.

