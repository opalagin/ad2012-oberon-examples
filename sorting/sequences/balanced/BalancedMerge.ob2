<*+ MAIN *>
MODULE BalancedMerge;

IMPORT Out, Files, Runs;

CONST N = 5;
  
VAR 
  src, dst: Files.File;
  r: Files.Rider;

PROCEDURE BalancedMerge(src: Files.File): Files.File;
VAR 
  i, j, m, tx: INTEGER;
  L, k1, k2, K1: INTEGER;
  min, x: INTEGER;
  t: ARRAY N OF INTEGER; (*index map*)
  R: Runs.Rider; (*source*)
  f, g: ARRAY N OF Files.File;
  r, w: ARRAY N OF Runs.Rider;
BEGIN 
  Runs.Set(R, src);
  FOR i := 0 TO N - 1 DO
    g[i] := Files.New(""); 
    Files.Set(w[i], g[i], 0)
  END;
  (*distribute initial runs from src to g[0] ... g[N-1]*)
  j := 0; 
  L := 0;
  REPEAT
    REPEAT 
      Runs.copy(R, w[j])
    UNTIL R.eor;
    INC(L); 
    INC(j);
    IF j = N THEN 
      j := 0 
    END
  UNTIL R.eof;
  REPEAT
    IF L < N THEN 
      k1 := L 
    ELSE 
      k1 := N 
    END;
    K1 := k1;
    FOR i := 0 TO k1 - 1 DO 
      (*set input riders*)
      Runs.Set(r[i], g[i])
    END;
    FOR i := 0 TO k1 - 1 DO 
      (*set output riders*)
      g[i] := Files.New(""); 
      Files.Set(w[i], g[i], 0)
    END;
    (*merge from r[0] ... r[k1-1] to w[0] ... w[K1-1]*)
    FOR i := 0 TO k1 - 1 DO 
      t[i] := i 
    END;
    L := 0; (*nof runs merged*)
    j := 0;
    REPEAT (*merge on run from inputs to w[j]*)
      INC(L); 
      k2 := k1;
      REPEAT (*select the minimal key*)
        m := 0; 
        min := r[t[0]].first; 
        i := 1;
        WHILE i < k2 DO
          x := r[t[i]].first;
          IF x < min THEN 
            min := x; 
            m := i 
          END;
          INC(i)
        END;
        Runs.copy(r[t[m]], w[j]);
        IF r[t[m]].eof THEN 
          (*eliminate this sequence*)
          DEC(k1); 
          DEC(k2);
          t[m] := t[k2]; 
          t[k2] := t[k1]
        ELSIF r[t[m]].eor THEN 
          (*close run*)
          DEC(k2);
          tx := t[m]; 
          t[m] := t[k2]; 
          t[k2] := tx
        END
      UNTIL k2 = 0;
      INC(j);
      IF j = K1 THEN 
        j := 0 
      END
    UNTIL k1 = 0
  UNTIL L = 1;
  RETURN g[0]
END BalancedMerge;

BEGIN
  Out.String("Generated sequence:"); Out.Ln();
  src := Files.New('Test Input');
  Runs.OpenRandomSeq(src, 200, 7);
  Runs.ListSeq(src);
    
  Out.Ln();
  Out.String("Balanced merge:"); Out.Ln();
  dst := BalancedMerge(src);
  Runs.ListSeq(dst);
END BalancedMerge.
