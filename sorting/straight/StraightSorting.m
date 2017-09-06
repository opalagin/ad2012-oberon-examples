MODULE StraightSorting;

IMPORT Out, Utils;

VAR
  a0, a1: ARRAY 10 OF INTEGER;


(* 2.2.1 Sorting by Straight Insertion *)
PROCEDURE InsertionSort(VAR a: ARRAY OF INTEGER);
VAR
  x, i, j: INTEGER;
BEGIN
  FOR i := 1 TO LEN(a) - 1 DO
    x := a[i];
    j := i;
    WHILE (j > 0) & (x < a[j - 1]) DO
      a[j] := a[j - 1];
      DEC(j);
    END;
    a[j] := x;
  END;
END InsertionSort;


(* 2.2.1 Sorting by Binary Insertion *)
PROCEDURE BinInsertionSort(VAR a: ARRAY OF INTEGER);
VAR
  x, i, j, m, L, R: INTEGER;
BEGIN
  FOR i := 1 TO LEN(a) - 1 DO
    x := a[i];
    L := 0;
    R := i;
    WHILE (L < R) DO
      m := (L + R)DIV 2;
      IF (x >= a[m]) THEN
        L := m + 1;
      ELSE
        R := m
      END;
    END;
    FOR j := i TO R + 1 BY - 1 DO
      a[j] := a[j - 1];
    END;
    a[R] := x;
  END;
END BinInsertionSort;


(* 2.2.2 Sorting by Straight Selection *)
PROCEDURE SelectionSort(VAR a: ARRAY OF INTEGER);
VAR
  x: INTEGER;
  i, j, k, N: INTEGER;
BEGIN
  N := LEN(a);
  FOR i := 0 TO N - 2 DO
    k := i;
    x := a[i];
    FOR j := i + 1 TO N - 1 DO
      IF a[j] < x THEN
        k := j;
        x := a[k]
      END
    END;
    a[k] := a[i];
    a[i] := x
  END
END SelectionSort;


(* 2.2.3 Sorting by Straight Exchange *)
PROCEDURE BubbleSort(VAR a: ARRAY OF INTEGER);
VAR
  x: INTEGER;
  i, j, N: INTEGER;
BEGIN
  N := LEN(a);
  FOR i := 1 TO N - 1 DO
    FOR j := N - 1 TO i BY -1 DO
      IF a[j] < a[j - 1] THEN
        x := a[j - 1];
        a[j - 1] := a[j];
        a[j] := x;
      END;
    END;
  END;
END BubbleSort;


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
  a0[9] := 0;

  Out.String("--- Straight Insertion Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  InsertionSort(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

  Out.Ln();

  Out.String("--- Binary Insertion Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  BinInsertionSort(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

  Out.Ln();

  Out.String("--- Straight Selection Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  SelectionSort(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

  Out.Ln();

  Out.String("--- Straight Exchange Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  BubbleSort(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

END StraightSorting.
