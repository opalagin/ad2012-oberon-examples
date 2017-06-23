<*+ MAIN *>
MODULE AdvancedSorting;

IMPORT Out, Utils;

VAR 
  a0, a1: ARRAY 10 OF INTEGER;

(* Insertion Sort By Diminishing Increment (ShellSort) *)
PROCEDURE ShellSort(VAR a: ARRAY OF INTEGER);
CONST 
  T = 4;
VAR
  i, j, N: LONGINT;
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
    
END AdvancedSorting.

