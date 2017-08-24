MODULE EightQueens;

IMPORT Out;

VAR
    x: ARRAY 8 OF INTEGER;
    a: ARRAY 8 OF BOOLEAN;
    b, c: ARRAY 15 OF BOOLEAN;
    m: INTEGER;

PROCEDURE Write; (* ADenS35_Queens *)
VAR k: INTEGER;
BEGIN
    FOR k := 0 TO 7 DO
        Out.Int(x[k], 4)
    END;
    Out.Ln()
END Write;

PROCEDURE Try (i: INTEGER);
VAR j: INTEGER;
BEGIN
    IF i < 8 THEN
        FOR j := 0 TO 7 DO
            IF a[j] & b[i+j] & c[i-j+7] THEN
                x[i] := j; a[j] := FALSE; b[i+j] := FALSE; c[i-j+7] := FALSE;
                Try(i + 1);
                x[i] := -1; a[j] := TRUE; b[i+j] := TRUE; c[i-j+7] := TRUE
            END
        END
    ELSE
        Write;
        m := m + 1 (*solutions count*)
    END
END Try;

PROCEDURE AllQueens;
VAR i, j: INTEGER;
BEGIN
    FOR i := 0 TO 7 DO
        a[i] := TRUE; x[i] := -1
    END;
    FOR i := 0 TO 14 DO
        b[i] := TRUE; c[i] := TRUE
    END;
    m := 0;
    Try(0);
    Out.String('no. of solutions: '); Out.Int(m, 1); Out.Ln
END AllQueens;

BEGIN
    AllQueens
END EightQueens.
