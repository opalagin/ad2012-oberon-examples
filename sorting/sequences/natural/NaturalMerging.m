MODULE NaturalMerging;

IMPORT Out, ADFiles, Runs;

VAR 
  src, dst: ADFiles.File;
  r: ADFiles.Rider;
  n: INTEGER;
  ch: CHAR;
  
PROCEDURE copyrun(VAR x, y: Runs.Rider); (* ADenS24_MergeSorts *)
BEGIN 
  (*from x to y*)
  REPEAT Runs.copy(x, y) UNTIL x.eor
END copyrun;

(* 2.4.2 Natural Merging *)
PROCEDURE NaturalMerge(src: ADFiles.File): ADFiles.File;
VAR 
  L: INTEGER; (*no. of runs merged*)
  f0, f1, f2: ADFiles.File;
  r0, r1, r2: Runs.Rider;
BEGIN
  Runs.Set(r2, src);
  REPEAT
    f0 := ADFiles.New("test0"); ADFiles.Set(r0, f0, 0);
    f1 := ADFiles.New("test1"); ADFiles.Set(r1, f1, 0);
    (*distribute from r2 to r0 and r1*)
    REPEAT
      copyrun(r2, r0);
      IF ~r2.eof THEN copyrun(r2, r1) END
    UNTIL r2.eof;
    Runs.Set(r0, f0); Runs.Set(r1, f1);
    f2 := ADFiles.New(""); ADFiles.Set(r2, f2, 0);
    (*merge from r0 and r1 to r2*)
    L := 0;
    REPEAT
      REPEAT
        IF r0.first < r1.first THEN
          Runs.copy(r0, r2);
          IF r0.eor THEN copyrun(r1, r2) END
        ELSE
          Runs.copy(r1, r2);
          IF r1.eor THEN copyrun(r0, r2) END
        END
      UNTIL r0.eor & r1.eor;
      INC(L)
    UNTIL r0.eof OR r1.eof;
    WHILE ~r0.eof DO 
      copyrun(r0, r2); INC(L)
    END;
    WHILE ~r1.eof DO 
      copyrun(r1, r2); INC(L)
    END;
    Runs.Set(r2, f2)
  UNTIL L = 1;
  RETURN f2
END NaturalMerge;

BEGIN
  Out.String("Generated sequence:"); Out.Ln();
  src := ADFiles.New('Test Input');
  Runs.OpenRandomSeq(src, 200, 7);
  Runs.ListSeq(src);
  
  Out.Ln();
  Out.String("Naturaly merged:"); Out.Ln();
  dst := NaturalMerge(src);
  Runs.ListSeq(dst);
  
END NaturalMerging.
