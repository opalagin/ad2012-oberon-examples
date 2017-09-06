MODULE AdvancedSorting;

IMPORT Out, Utils;

VAR
  a0, a1: ARRAY 10 OF INTEGER;
  k: INTEGER;

(* Insertion Sort By Diminishing Increment (ShellSort) *)
PROCEDURE ShellSort(VAR a: ARRAY OF INTEGER);
CONST
  T = 4;
VAR
  i, j, N: INTEGER;
  k, m, x: INTEGER;
  h: ARRAY T OF INTEGER;
BEGIN
  N := LEN(a);
  h[0] := 9;
  h[1] := 5;
  h[2] := 3;
  h[3] := 1;
  FOR m := 0 TO T - 1 DO
    k := h[m];
    FOR i := k TO N - 1 DO
      x := a[i];
      j := i - k;

      WHILE (j >= k) & (x < a[j]) DO
        a[j + k] := a[j];
        j := j - k;
      END;

      IF (j >= k)OR(x >= a[j]) THEN
        a[j + k] := x
      ELSE
        a[j + k] := a[j];
        a[j] := x;
      END;
    END;
  END;
END ShellSort;


(* 2.3.2 Tree Sort (Heapsort) *)
PROCEDURE HeapSort(VAR a: ARRAY OF INTEGER);
VAR
  N, L, R: INTEGER;
  x: INTEGER;

  PROCEDURE sift(L, R: INTEGER);
  VAR
    i, j: INTEGER;
    x: INTEGER;
  BEGIN
    i := L;
    j := 2 * i + 1;
    x := a[i];

    IF (j < R) & (a[j] < a[j + 1]) THEN
      INC(j);
    END;

    WHILE (j <= R) & (x < a[j]) DO
      a[i] := a[j];
      i := j; j := 2 * j + 1;
      IF (j < R) & (a[j] < a[j + 1]) THEN
        INC(j);
      END;
    END;

    a[i] := x;
  END sift;

BEGIN
  N := LEN(a);
  L := N DIV 2;
  R := N - 1;

  WHILE L > 0 DO
    DEC(L);
    sift(L, R);
  END;

  WHILE R > 0 DO
    x := a[0]; a[0] := a[R]; a[R] := x;
    DEC(R);
    sift(L, R);
  END;
END HeapSort;


(* 2.3.3 Partition Sort (Quicksort) *)
PROCEDURE QuickSort(VAR a: ARRAY OF INTEGER);
VAR
  N: INTEGER;

  PROCEDURE sort(L, R: INTEGER);
  VAR
    i, j: INTEGER;
    x, w: INTEGER;
  BEGIN
    i := L; j := R;
    (* partition *)
    x := a[(L + R) DIV 2];
    REPEAT
      WHILE a[i] < x DO
        INC(i);
      END;
      WHILE x < a[j] DO
        DEC(j);
      END;
      IF (i <= j) THEN
        w := a[i]; a[i] := a[j]; a[j] := w;
        INC(i); DEC(j);
      END;
    UNTIL i > j;
    (* recursively sort partitions *)
    IF (L < j) THEN
      sort(L, j);
    END;
    IF (i < R) THEN
      sort(i, R);
    END;
  END sort;

BEGIN
  N := LEN(a);
  sort(0, N - 1);
END QuickSort;


(* 2.3.3 Non-recursive Quicksort *)
PROCEDURE NRQuickSort(VAR a: ARRAY OF INTEGER);
CONST M = 12; (* OP: this can be computed as log(N) *)
  VAR
    i, j, L, R, s, N: INTEGER;
    x, w: INTEGER;
    low, high: ARRAY M OF INTEGER; (* index stack *)
BEGIN
  N := LEN(a);
  s := 0; low[0] := 0; high[0] := N - 1;
  REPEAT (* take top request from stack *)
    L := low[s]; R := high[s]; DEC(s);
    REPEAT (* partition a[L]..a[R] *)
      i := L; j := R; x := a[(L + R) DIV 2];
      REPEAT
        WHILE a[i] < x DO INC(i) END;
        WHILE x < a[j] DO DEC(j) END;
        IF i <= j THEN
          w := a[i]; a[i] := a[j]; a[j] := w;
          INC(i); DEC(j);
        END;
      UNTIL i > j;
      IF i < R THEN (* stack request to sort right partition *)
        INC(s); low[s] := i; high[s] := R;
      END;
      R := j; (* now L and R delimit left partition *)
    UNTIL L >= R;
  UNTIL s < 0;
END NRQuickSort;


(* 2.3.4 Finding the Media (k-th smallest of n items) *)
PROCEDURE Find(VAR a: ARRAY OF INTEGER; k: INTEGER);
VAR
  i, j, N, L, R: INTEGER;
  x, w: INTEGER;
BEGIN
  N := LEN(a);
  L := 0; R := N - 1;
  WHILE L < R - 1 DO
    x := a[k]; i := L; j := R;
    REPEAT
      WHILE a[i] < x DO
        INC(i)
      END;
      WHILE x < a[j]DO
        DEC(j)
      END;
      IF i <= j THEN
        w := a[i]; a[i] := a[j]; a[j] := w;
        INC(i); DEC(j);
      END;
    UNTIL i > j;
    IF j < k THEN
      L := i
    END;
    IF k < i THEN
      R := j
    END;
  END;
END Find;

(* MAIN *)
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

  Out.String("--- Shell Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  ShellSort(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

  Out.Ln();
  Out.String("--- Heap Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  HeapSort(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

  Out.Ln();
  Out.String("--- Quick Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  QuickSort(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

  Out.Ln();
  Out.String("--- Non-recursive Quick Sort ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  NRQuickSort(a1);
  Out.String("Sorted = "); Utils.PrintArray(a1); Out.Ln();

  Out.Ln();
  Out.String("--- Finding median ---"); Out.Ln();
  Utils.CopyArray(a0, a1);
  Out.String("Unsorted = "); Utils.PrintArray(a1); Out.Ln();
  k := LEN(a1) DIV 2;
  Out.String("Median = "); Find(a1, k); Out.Int(a1[k], 0); Out.Ln();

END AdvancedSorting.
