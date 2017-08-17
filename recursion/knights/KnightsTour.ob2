<* +MAIN *>
MODULE KnightsTour;

IMPORT Out;

CONST n = 6; nsqr = 36;

VAR 
  h: ARRAY n, n OF INTEGER;
  dx, dy: ARRAY 8 OF INTEGER;
  
  i, j: INTEGER;
  done: BOOLEAN;
  
(* Forward declarations for compiler *)
PROCEDURE ^TryNextMove(x, y, i: INTEGER; VAR done: BOOLEAN);
  
PROCEDURE CanBeDone(u, v, i: INTEGER): BOOLEAN;
VAR 
  done: BOOLEAN;
BEGIN
  h[u, v] := i;
  TryNextMove(u, v, i, done);
  IF ~done THEN 
    h[u, v] := 0 
  END;
  RETURN done
END CanBeDone;

PROCEDURE TryNextMove(x, y, i: INTEGER; VAR done: BOOLEAN);
VAR 
  eos: BOOLEAN; u, v: INTEGER; k: INTEGER;
  
  PROCEDURE Next(VAR eos: BOOLEAN; VAR u, v: INTEGER);
  BEGIN
    REPEAT
      INC(k);
      IF k < 8 THEN 
        u := x + dx[k]; v := y + dy[k]
      END;
    UNTIL (k = 8) OR ((0 <= u) & (u < n) & (0 <= v) & (v < n) & (h[u, v] = 0)) ;
    eos := (k = 8)
  END Next;
  
  PROCEDURE First(VAR eos: BOOLEAN; VAR u, v: INTEGER);
  BEGIN
    eos := FALSE; k := -1; Next(eos, u, v)
  END First;
  
BEGIN
  IF i < nsqr THEN
    First(eos, u, v);
    WHILE ~eos & ~CanBeDone(u, v, i + 1)DO
      Next(eos, u, v)
    END;
    done := ~eos
  ELSE
    done := TRUE
  END;
END TryNextMove;

PROCEDURE Clear;
VAR 
  i, j: INTEGER;
BEGIN
  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n - 1 DO 
      h[i, j] := 0 
    END
  END
END Clear;

PROCEDURE KnightsTour(x0, y0: INTEGER; VAR done: BOOLEAN);
BEGIN
  Clear; h[x0, y0] := 1; TryNextMove(x0, y0, 1, done);
END KnightsTour;

BEGIN
  (* Knight movement rules *)
  dx[0] := 2; dx[1] := 1; dx[2] := -1; dx[3] := -2; dx[4] := -2; dx[5] := -1; dx[6] := 1;  dx[7] := 2;
  dy[0] := 1; dy[1] := 2; dy[2] := 2;  dy[3] := 1;  dy[4] := -1; dy[5] := -2; dy[6] := -2; dy[7] := -1;
  
  KnightsTour(0, 0, done);
  
  (* Results output *)
  FOR i := 0 TO n - 1 DO
    FOR j := 0 TO n -1 DO
      Out.Int(h[i, j], 5);
    END;
    Out.Ln()
  END;
  
END KnightsTour.
