MODULE Runs;

IMPORT Files, Out;

TYPE 
  Rider* = RECORD 
  (Files.Rider) first*: INTEGER; eor*: BOOLEAN 
  END;
  
PROCEDURE OpenRandomSeq*(f: Files.File; length, seed: INTEGER);
VAR 
  i: INTEGER; w: Files.Rider;
BEGIN
  Files.Set(w, f, 0);
  FOR i := 0 TO length - 1 DO
    Files.WriteInt(w, seed); 
    seed := (31 * seed)MOD 997 + 5
  END;
  Files.Close(f)
END OpenRandomSeq;

PROCEDURE Set*(VAR r: Rider; f: Files.File);
BEGIN
  Files.Set(r, f, 0); 
  Files.ReadInt(r, r.first); 
  r.eor := r.eof
END Set;

PROCEDURE copy*(VAR src, dest: Rider);
BEGIN
  dest.first := src.first;
  Files.WriteInt(dest, dest.first); 
  Files.ReadInt(src, src.first);
  src.eor := src.eof OR(src.first < dest.first)
END copy;

(* Modified from original source code for Oberon-2/XDS *)
PROCEDURE ListSeq*(f: Files.File);
VAR 
  x, y, k, n: INTEGER; r: Files.Rider;
BEGIN
  k := 0; 
  n := 0;
  Files.Set(r, f, 0); 
  Files.ReadInt(r, x);
  WHILE ~r.eof DO
    Out.Int(x, 6); 
    INC(k); 
    Files.ReadInt(r, y);
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
