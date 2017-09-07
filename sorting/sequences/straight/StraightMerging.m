MODULE StraightMerging;

IMPORT Out, Utils;

VAR
  a0, a1: ARRAY 20 OF INTEGER;

PROCEDURE StraightMerge(VAR a: ARRAY OF INTEGER);
VAR
  i, j, k, L, t: INTEGER; (* index range of a is 0..2*n-1 *)
  h, m, p, q, r: INTEGER; up: BOOLEAN;
  n: INTEGER;
BEGIN
  n := LEN(a) DIV 2;
  up := TRUE; p := 1;
  REPEAT
    h := 1; m := n;
    IF up THEN
      i := 0; j := n - 1; k := n; L := 2 * n - 1;
    ELSE
      k := 0; L := n - 1; i := n; j := 2 * n - 1;
    END;
    REPEAT (* merge a run from i- and j-sources to k-destination *)
      IF m >= p THEN q := p ELSE q := m END;
      m := m - q;
      IF m >= p THEN r := p ELSE r := m END;
      m := m - r;
      WHILE (q > 0) & (r > 0) DO
        IF a[i] < a[j] THEN
          a[k] := a[i]; k := k + h; i := i + 1; q := q - 1;
        ELSE
          a[k] := a[j]; k := k + h; j := j - 1; r := r - 1;
        END;
      END;
      WHILE r > 0 DO
        a[k] := a[j]; k := k + h; j := j - 1; r := r - 1;
      END;
      WHILE q > 0 DO
        a[k] := a[i]; k := k + h; i := i + 1; q := q - 1;
      END;
      h := -h; t := k; k := L; L := t
    UNTIL m = 0;
    up := ~up; p := 2 * p;
  UNTIL p >= n;
  IF ~up THEN
    FOR i := 0 TO n - 1 DO
      a[i] := a[i + n]
    END
  END;
END StraightMerge;


BEGIN
  a0[0] := 6;
  a0[1] := 9;
  a0[2] := 1;
  a0[3] := 2;
  a0[4] := 4;
  a0[5] := 3;
  a0[6] := 7;
  a0[7] := 5;
  a0[8] := 8;
  a0[9] := 10;

  Out.String("--- Straight Merge Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  StraightMerge(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

END StraightMerging.
