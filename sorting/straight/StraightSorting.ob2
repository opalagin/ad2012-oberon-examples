<*+ MAIN *>
MODULE StraightSorting;

IMPORT In, Out;
  
VAR 
  a0, a1: ARRAY 10 OF INTEGER;


(* 2.2.1 Sorting by Straight Insertion *)
PROCEDURE StraightInsertion(VAR a: ARRAY OF INTEGER);
VAR x, i, j: INTEGER;
BEGIN
  FOR i := 1 TO LEN(a)-1 DO
    x := a[i]; 
    j := i;
    WHILE (j > 0) & (x < a[j-1]) DO
      a[j] := a[j-1]; 
      DEC(j);
    END;
    a[j] := x;
  END;
END StraightInsertion;


(* 2.2.1 Sorting by Binary Insertion *)
PROCEDURE BinaryInsertion(VAR a: ARRAY OF INTEGER);
VAR x, i, j, m, L, R: INTEGER;
BEGIN
  FOR i := 1 TO LEN(a)-1 DO
    x := a[i]; 
    L := 0; 
    R := i;
    WHILE (L < R) DO
      m := (L + R) DIV 2;
      IF (x <= a[m]) THEN 
        L := m+1; 
      ELSE 
        R := m 
      END;
    END;
    FOR j := i TO R+1 BY -1 DO 
      a[j] := a[j-1]; 
    END;
    a[R] := x;
  END;
END BinaryInsertion;


PROCEDURE PrintArray(a: ARRAY OF INTEGER);
VAR i: INTEGER;
BEGIN
  Out.String("[");
    FOR i := 0 TO LEN(a)-1 DO
      Out.Int(a[i], 0); 
      IF (i # LEN(a)-1) THEN 
        Out.String(", "); 
      END;
    END;
    Out.String("]");
END PrintArray;


PROCEDURE CopyArray(in: ARRAY OF INTEGER; VAR out: ARRAY OF INTEGER);
VAR i: INTEGER;
BEGIN
  FOR i := 0 TO LEN(out)-1 DO
    out[i] := in[i];
  END;
END CopyArray;


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
  
  Out.String("--- Straight Insertion ---"); 
  Out.Ln();
  CopyArray(a0, a1);
  Out.String("Unsorted = "); 
  PrintArray(a1); 
  Out.Ln();
  StraightInsertion(a1);
  Out.String("Sorted = "); 
  PrintArray(a1); 
  Out.Ln();
  
  Out.Ln();
  
  Out.String("--- Binary Insertion ---"); 
  Out.Ln();
  CopyArray(a0, a1);
  Out.String("Unsorted = "); 
  PrintArray(a1); 
  Out.Ln();
  BinaryInsertion(a1);
  Out.String("Sorted = "); 
  PrintArray(a1); 
  Out.Ln();
    
END StraightSorting.
