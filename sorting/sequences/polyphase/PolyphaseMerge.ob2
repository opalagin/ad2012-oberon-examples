<* +MAIN *>
MODULE PolyphaseMerge;

IMPORT Out, Files, Runs;

CONST 
  N = 6;

VAR 
  src, dst: Files.File;

(* 2.4.4 Polyphase Sort *)
PROCEDURE Polyphase(src: Files.File): Files.File;
VAR 
  i, j, mx, tn: INTEGER;
  k, dn, z, level: INTEGER;
  x, min: INTEGER;
  a, d: ARRAY N OF INTEGER;
  t, ta: ARRAY N OF INTEGER; (*index maps*)
  R: Runs.Rider; (*source*)
  f: ARRAY N OF Files.File;
  r: ARRAY N OF Runs.Rider;
  
  PROCEDURE select;
  VAR 
    i, z: INTEGER;
  BEGIN
    IF d[j] < d[j + 1]THEN
      INC(j)
    ELSE
      IF d[j] = 0 THEN
        INC(level);
        z := a[0];
        FOR i := 0 TO N - 2 DO
          d[i] := z + a[i + 1] - a[i]; 
          a[i] := z + a[i + 1]
        END
      END;
      j := 0
    END;
    DEC(d[j])
  END select;
  
  PROCEDURE copyrun; (*from src to f[j]*)
  BEGIN
    REPEAT 
      Runs.copy(R, r[j])
    UNTIL R.eor
  END copyrun;
  
BEGIN
  Runs.Set(R, src);
  FOR i := 0 TO N - 2 DO
    a[i] := 1; 
    d[i] := 1;
    f[i] := Files.New(""); 
    Files.Set(r[i], f[i], 0)
  END;
  (*distribute initial runs*)
  level := 1; 
  j := 0; 
  a[N - 1] := 0; 
  d[N - 1] := 0;
  REPEAT
    select; 
    copyrun
  UNTIL R.eof OR(j = N - 2) ;
  WHILE ~R.eof DO
    select; (*r[j].first = last item written on f[j]*)
    IF r[j].first <= R.first THEN
      copyrun;
      IF R.eof THEN 
        INC(d[j])
      ELSE 
        copyrun 
      END
    ELSE
      copyrun
    END
  END;
  FOR i := 0 TO N - 2 DO
    t[i] := i; 
    Runs.Set(r[i], f[i])
  END;
  t[N - 1] := N - 1;
  REPEAT (*merge from t[0] ... t[N-2] to t[N-1]*)
    z := a[N - 2]; 
    d[N - 1] := 0;
    f[t[N - 1]] := Files.New(""); 
    Files.Set(r[t[N - 1]], f[t[N - 1]], 0);
    REPEAT (*merge one run*)
      k := 0;
      FOR i := 0 TO N - 2 DO
        IF d[i] > 0 THEN
          DEC(d[i])
        ELSE
          ta[k] := t[i]; 
          INC(k)
        END
      END;
      IF k = 0 THEN
        INC(d[N - 1])
      ELSE 
        (*merge one real run from t[0] ... t[k-1] to t[N-1]*)
        REPEAT
          mx := 0; 
          min := r[ta[0]].first; 
          i := 1;
          WHILE i < k DO
            x := r[ta[i]].first;
            IF x < min THEN 
              min := x; 
              mx := i 
            END;
            INC(i)
          END;
          Runs.copy(r[ta[mx]], r[t[N - 1]]);
          IF r[ta[mx]].eor THEN
            ta[mx] := ta[k - 1]; 
            DEC(k)
          END
        UNTIL k = 0
      END;
      DEC(z)
    UNTIL z = 0;
    Runs.Set(r[t[N - 1]], f[t[N - 1]]); (*rotate sequences*)
    tn := t[N - 1]; 
    dn := d[N - 1]; 
    z := a[N - 2];
    FOR i := N - 1 TO 1 BY - 1 DO
      t[i] := t[i - 1]; 
      d[i] := d[i - 1]; 
      a[i] := a[i - 1] - z
    END;
    t[0] := tn; 
    d[0] := dn; 
    a[0] := z;
    DEC(level)
  UNTIL level = 0;
  RETURN f[t[0]]
END Polyphase;

BEGIN
  Out.String("Generated sequence:"); Out.Ln();
  src := Files.New('Test Input');
  Runs.OpenRandomSeq(src, 200, 7);
  Runs.ListSeq(src);
      
  Out.Ln();
  Out.String("Polyphase merge:"); Out.Ln();
  dst := Polyphase(src);
  Runs.ListSeq(dst);
END PolyphaseMerge.
