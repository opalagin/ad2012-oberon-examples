MODULE Utils;

IMPORT Out;


PROCEDURE PrintArray*(a: ARRAY OF INTEGER);
VAR 
  i: INTEGER;
BEGIN
  Out.String("[");
  FOR i := 0 TO LEN(a) - 1 DO
    Out.Int(a[i], 0); 
    IF (i # LEN(a) - 1) THEN 
      Out.String(", "); 
    END;
  END;
  Out.String("]");
END PrintArray;


PROCEDURE CopyArray*(in: ARRAY OF INTEGER; VAR out: ARRAY OF INTEGER);
VAR 
  i: INTEGER;
BEGIN
  FOR i := 0 TO LEN(out) - 1 DO
    out[i] := in[i];
  END;
END CopyArray;

BEGIN
END Utils.
