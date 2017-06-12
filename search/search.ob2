<*+ MAIN *>
MODULE search;

IMPORT InOut;

VAR
  i: INTEGER; 
  a: ARRAY 100 OF INTEGER;

(* 1.8.1: Linear search as stated by N. Wirth *)
PROCEDURE Search(a: ARRAY OF INTEGER; n: INTEGER; v: INTEGER): INTEGER;
VAR i: INTEGER;
BEGIN
  i := 0;
  WHILE (i < n) & (a[i] # v) DO INC(i) END;
  RETURN i;
END Search;

(*  1.8.2: The latest (efficient) version of binary search *)
PROCEDURE BSearch(a: ARRAY OF INTEGER; n: INTEGER; v: INTEGER): INTEGER;
VAR l, r, m: INTEGER;
BEGIN
  l := 0;
  r := n;
  WHILE (l < r) DO
    m := (l + r - 1) DIV 2;
    IF a[m] < v THEN
      l := m + 1;
    ELSE
      r := m;
    END; 
  END;
  RETURN r;
END BSearch;

BEGIN
  FOR i := 0 TO 99 DO a[i] := i + 1 END;
  
  InOut.WriteString("Searching for 99 in the array of 100 numbers"); 
  InOut.WriteLn();
  
  InOut.WriteString("- Linear search: ");
  i := Search(a, 100, 99);
  InOut.WriteInt(i, 1);
  InOut.WriteLn();
  
  InOut.WriteString("- Binary search: ");
  i := BSearch(a, 100, 99);
  InOut.WriteInt(i, 1);
  InOut.WriteLn();
  
  InOut.WriteLn();
  (*-------------------------------------------------------------- *)
  
  InOut.WriteString("Searching for 1 in the array of 100 numbers"); 
  InOut.WriteLn();
    
  InOut.WriteString("- Linear search: ");
  i := Search(a, 100, 1);
  InOut.WriteInt(i, 1);
  InOut.WriteLn();
    
  InOut.WriteString("- Binary search: ");
  i := BSearch(a, 100, 1);
  InOut.WriteInt(i, 1);
  InOut.WriteLn();
    
END search.
