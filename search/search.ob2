<*+ MAIN *>
MODULE search;

IMPORT Out;

VAR
  i: LONGINT; 
  a: ARRAY 100 OF INTEGER;

(* 1.8.1: Linear search as stated by N. Wirth *)
PROCEDURE Search(a: ARRAY OF INTEGER; v: INTEGER): LONGINT;
VAR i: LONGINT;
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
PROCEDURE BSearch(a: ARRAY OF INTEGER; v: INTEGER): LONGINT;
VAR l, r, m: LONGINT;
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
  IF r = LEN(a) THEN
    RETURN -1
  ELSE
    RETURN r
  END;
END BSearch;

BEGIN
  FOR i := 1 TO LEN(a)-1 DO a[i] := a[i-1] + 1 END;
  
  Out.String("Searching in the sorted array [0, 1, 2, .., 99]"); 
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
