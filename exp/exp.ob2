<*+ MAIN *>
MODULE exp;

IMPORT InOut, Out, In;

PROCEDURE Exp(x: REAL; y: INTEGER): REAL;
VAR
  i: INTEGER;
  z: REAL;
BEGIN
  i := y;
  z := 1.0;
  WHILE i > 0 DO
    IF ODD(i) THEN z := z * x END;
    x := x * x; 
    i := i DIV 2;
  END;
  RETURN z;
END Exp;

BEGIN
  InOut.WriteString("1^1 = "); 
  Out.Real(Exp(1, 1), 1); 
  InOut.WriteLn();
  
  InOut.WriteString("10^2 = "); 
  Out.Real(Exp(10, 2), 1); 
  InOut.WriteLn();
  
  InOut.WriteString("100^3 = "); 
  Out.Real(Exp(100, 3), 1); 
  InOut.WriteLn();
  
  InOut.WriteString("5^4 = "); 
  Out.Real(Exp(5, 4), 1); 
  InOut.WriteLn();
  
  InOut.WriteString("50^6 = "); 
  Out.Real(Exp(50, 6), 1); 
  InOut.WriteLn();
END exp.
