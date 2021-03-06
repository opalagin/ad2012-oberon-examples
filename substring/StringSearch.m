MODULE StringSearch;

IMPORT Out, Strings;

(* Strings are NULL-terminated *)
TYPE
  String = ARRAY 255 OF CHAR;

VAR
  test, a, b: String;

(* 1.9.1: Straight String Search *)
PROCEDURE IndexOf(p, s: String): INTEGER;
VAR
  i, j, N, M: INTEGER;
BEGIN
  i := 0;
  j := 0;
  N := Strings.Length(s);
  M := Strings.Length(p);

  WHILE (i <= N - M) & (j < M) DO
    IF s[i + j] = p[j] THEN
      INC(j);
    ELSE
      INC(i);
      j := 0;
    END
  END;

  IF i > N - M THEN
    RETURN -1
  END;

  RETURN i
END IndexOf;


(* 1.9.2 The Knuth-Morris-Pratt String Search *)
PROCEDURE KMPIndexOf(p, s: String): INTEGER;
VAR
  i, j, k, N, M: INTEGER;
  d: POINTER TO ARRAY OF INTEGER;
BEGIN
  N := Strings.Length(s);
  M := Strings.Length(p);
  NEW(d, M);

  (* compute shifts *)
  d[0] := -1;
  IF p[0] # p[1]THEN
    d[1] := 0
  ELSE
    d[1] := -1
  END;
  j := 1;
  k := 0;
  WHILE j < M - 1 DO
    IF (k >= 0) & (p[j] # p[k]) THEN
      k := d[k];
    ELSE
      INC(j);
      INC(k);
      IF p[j] # p[k] THEN
        d[j] := k
      ELSE
        d[j] := d[k]
      END;
    END;
  END;

  (* scan with shifts *)
  i := 0;
  j := 0;
  WHILE (j < M) & (i < N) DO
    IF (j >= 0) & (s[i] # p[j]) THEN
      j := d[j];
    ELSE
      INC(i);
      INC(j);
    END;
  END;

  IF j = M THEN
    RETURN i - M
  END;

  RETURN -1
END KMPIndexOf;


(* 1.9.3 Simplfied Boyer-Moore String Search *)
PROCEDURE BMIndexOf(p, s: String): INTEGER;
VAR
  i, j, k, M, N: INTEGER;
  d: POINTER TO ARRAY OF INTEGER;
BEGIN
  M := Strings.Length(p);
  N := Strings.Length(s);

  (* compute shifts *)
  NEW(d, 128);
  FOR i := 0 TO 127 DO
    d[i] := M
  END;
  FOR j := 0 TO M-2 DO
    d[ORD(p[j])] := M - j - 1;
  END;

  (* scan with shifts *)
  i := M;
  j := M;
  k := M;
  WHILE (j > 0) & (i <= N) DO
    IF s[k-1] = p[j-1] THEN
      DEC(k);
      DEC(j);
    ELSE
        i := i + d[ORD(s[i-1])];
        j := M;
        k := i;
    END;
  END;

  IF j <= 0 THEN
    RETURN k
  END;

  RETURN -1
END BMIndexOf;


(* MAIN *)
BEGIN
  test := "Hoola-Hoola girls like Hooligan.";

  a := "Hooligan";
  b := "Hola";

  Out.String("S = ");
  Out.String(test);
  Out.Ln();

  Out.String("Straight indexOf('"); Out.String(a); Out.String("'): ");
  Out.Int(IndexOf(a, test), 0);
  Out.Ln();
  Out.String("Straight indexOf('"); Out.String(b); Out.String("'): ");
  Out.Int(IndexOf(b, test), 0);
  Out.Ln();

  Out.String("KMP indexOf('"); Out.String(a); Out.String("'): ");
  Out.Int(KMPIndexOf(a, test), 0);
  Out.Ln();
  Out.String("KMP indexOf('"); Out.String(b); Out.String("'): ");
  Out.Int(KMPIndexOf(b, test), 0);
  Out.Ln();

  Out.String("BM indexOf('"); Out.String(a); Out.String("'): ");
  Out.Int(BMIndexOf(a, test), 0);
  Out.Ln();
  Out.String("BM indexOf('"); Out.String(b); Out.String("'): ");
  Out.Int(BMIndexOf(b, test), 0);
  Out.Ln();

END StringSearch.
