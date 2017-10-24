MODULE Runs;

IMPORT ADFiles, Out;

TYPE 
  Rider* = RECORD 
  (ADFiles.Rider) first*: INTEGER; eor*: BOOLEAN 
  END;
  
PROCEDURE OpenRandomSeq*(f: ADFiles.File; length, seed: INTEGER);
VAR 
  i: INTEGER; w: ADFiles.Rider;
BEGIN
  ADFiles.Set(w, f, 0);
  FOR i := 0 TO length - 1 DO
    ADFiles.WriteInt(w, seed); 
    seed := (31 * seed)MOD 997 + 5
  END;
  ADFiles.Close(f)
END OpenRandomSeq;

PROCEDURE Set*(VAR r: Rider; f: ADFiles.File);
BEGIN
  ADFiles.Set(r, f, 0); 
  ADFiles.ReadInt(r, r.first); 
  r.eor := r.eof
END Set;

PROCEDURE copy*(VAR src, dest: Rider);
BEGIN
  dest.first := src.first;
  ADFiles.WriteInt(dest, dest.first); 
  ADFiles.ReadInt(src, src.first);
  src.eor := src.eof OR(src.first < dest.first)
END copy;

(* Modified from original source code for Oberon-2/XDS *)
PROCEDURE ListSeq*(f: ADFiles.File);
VAR 
  x, y, k, n: INTEGER; r: ADFiles.Rider;
BEGIN
  k := 0; 
  n := 0;
  ADFiles.Set(r, f, 0); 
  ADFiles.ReadInt(r, x);
  WHILE ~r.eof DO
    Out.Int(x, 6); 
    INC(k); 
    ADFiles.ReadInt(r, y);
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
