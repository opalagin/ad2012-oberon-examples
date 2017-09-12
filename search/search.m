MODULE search;

IMPORT Out;

VAR
  i: INTEGER;
  a: ARRAY 100 OF INTEGER;

(* 1.8.1: Linear search as stated by N. Wirth *)
PROCEDURE Search(a: ARRAY OF INTEGER; v: INTEGER): INTEGER;
VAR i: INTEGER;
BEGIN
  i := 0;
  WHILE (i < LEN(a)) & (a[i] # v) DO INC(i) END;
  IF i = LEN(a) THEN
    RETURN -1
  ELSE
    RETURN i
  END;
END Search;

(*  1.8.2: The latest (efficient) version of binary search *)
PROCEDURE BSearch(a: ARRAY OF INTEGER; v: INTEGER): INTEGER;
VAR l, r, m: INTEGER;
BEGIN
  l := 0;
  r := LEN(a);
  WHILE (l < r) DO
    m := (l + r - 1) DIV 2;
    IF a[m] < v THEN
      l := m + 1;
    ELSE
      r := m;
    END;
  END;
  IF (r = LEN(a)) OR (a[r] # v) THEN
    RETURN -1
  ELSE
    RETURN r
  END;
END BSearch;

BEGIN
  a[0] := 10;
  FOR i := 1 TO LEN(a)-1 DO a[i] := a[i-1] + 1 END;

  Out.String("Searching in the sorted array [10, 11, 12, .., 109]");
  Out.Ln();

  Out.String("- Linear search: indexOf(89) = ");
  i := Search(a, 89);
  Out.Int(i, 1);
  Out.Ln();

  Out.String("- Binary search: indexOf(89) = ");
  i := BSearch(a, 89);
  Out.Int(i, 1);
  Out.Ln();

  Out.Ln();
  (*-------------------------------------------------------------- *)
  Out.String("- Linear search: indexOf(1) = ");
  i := Search(a, 1);
  Out.Int(i, 1);
  Out.Ln();

  Out.String("- Binary search: indexOf(1) = ");
  i := BSearch(a, 1);
  Out.Int(i, 1);
  Out.Ln();

  Out.Ln();
  (*-------------------------------------------------------------- *)

  Out.String("- Linear search: indexOf(200) = ");
  i := Search(a, 200);
  Out.Int(i, 1);
  Out.Ln();

  Out.String("- Binary search: indexOf(200) = ");
  i := BSearch(a, 200);
  Out.Int(i, 1);
  Out.Ln();

END search.
