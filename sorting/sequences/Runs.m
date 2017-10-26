MODULE Runs;

IMPORT Filez, Out;

TYPE 
  Rider* = RECORD 
  (Filez.Rider) first*: INTEGER; eor*: BOOLEAN 
  END;
  
PROCEDURE OpenRandomSeq*(f: Filez.File; length, seed: INTEGER);
VAR 
  i: INTEGER; w: Filez.Rider;
BEGIN
  Filez.Set(w, f, 0);
  FOR i := 0 TO length - 1 DO
    Filez.WriteInt(w, seed); 
    seed := (31 * seed)MOD 997 + 5
  END;
  Filez.Close(f)
END OpenRandomSeq;

PROCEDURE Set*(VAR r: Rider; f: Filez.File);
BEGIN
  Filez.Set(r, f, 0); 
  Filez.ReadInt(r, r.first); 
  r.eor := r.eof
END Set;

PROCEDURE copy*(VAR src, dest: Rider);
BEGIN
  dest.first := src.first;
  Filez.WriteInt(dest, dest.first); 
  Filez.ReadInt(src, src.first);
  src.eor := src.eof OR(src.first < dest.first)
END copy;

(* Modified from original source code for Oberon-2/XDS *)
PROCEDURE ListSeq*(f: Filez.File);
VAR 
  x, y, k, n: INTEGER; r: Filez.Rider;
BEGIN
  k := 0; 
  n := 0;
  Filez.Set(r, f, 0); 
  Filez.ReadInt(r, x);
  WHILE ~r.eof DO
    Out.Int(x, 6); 
    INC(k); 
    Filez.ReadInt(r, y);
    IF y < x THEN 
    (*end of run*) Out.String("|"); INC(n)
    END;
    x := y
  END;
  Out.String("$"); Out.Int(k, 5); Out.Int(n, 5);
  Out.Ln()
END ListSeq;

BEGIN
END Runs.
