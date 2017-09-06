MODULE exp;

IMPORT Out;

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
  Out.String("1^1 = ");
  Out.Real(Exp(1, 1));
  Out.Ln();

  Out.String("10^2 = ");
  Out.Real(Exp(10, 2));
  Out.Ln();

  Out.String("100^3 = ");
  Out.Real(Exp(100, 3));
  Out.Ln();

  Out.String("5^4 = ");
  Out.Real(Exp(5, 4));
  Out.Ln();

  Out.String("50^6 = ");
  Out.Real(Exp(50, 6));
  Out.Ln();
END exp.
