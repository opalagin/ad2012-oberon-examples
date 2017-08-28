(* 3.6 The Stable Marriage Problem *)
MODULE StableMarriages;

IMPORT In, Out;

CONST n = 8;

TYPE woman = INTEGER;
TYPE man = INTEGER;
TYPE rank = INTEGER;

VAR wmr: ARRAY n, n OF woman;
    mwr: ARRAY n, n OF man;
    x, y: ARRAY n OF INTEGER;
    single: ARRAY n OF BOOLEAN;
    rmw: ARRAY n, n OF rank;
    rwm: ARRAY n, n OF rank;

PROCEDURE write;
VAR m: man; rm, rw: INTEGER;
BEGIN
    rm := 0; rw := 0;
    FOR m := 0 TO n-1 DO
        Out.Int(x[m], 4);
        rm := rmw[m, x[m]] + rm; rw := rwm[x[m], m] + rw
    END;
    Out.Int(rm, 8); Out.Int(rw, 4); Out.Ln()
END write;

PROCEDURE stable (m, w, r: INTEGER): BOOLEAN;
VAR pm, pw, rank, i, lim: INTEGER;
    S: BOOLEAN;
BEGIN
    i := -1; S := TRUE;
    REPEAT
        INC(i);
        IF i < r THEN
            pw := wmr[m,i];
            IF ~single[pw] THEN
                S := rwm[pw,m] > rwm[pw, y[pw]]
            END
        END
    UNTIL (i = r) OR ~S;

    i := -1; lim := rwm[w,m];
    REPEAT
        INC(i);
        IF i < lim THEN
            pm := mwr[w,i];
            IF pm < m THEN
                S := rmw[pm,w] > rmw[pm, x[pm]]
            END
        END
    UNTIL (i = lim) OR ~S;

    RETURN S
END stable;

PROCEDURE Try (m: INTEGER);
VAR w, r: INTEGER;
BEGIN
    IF m < n THEN
        FOR r := 0 TO n-1 DO
            w := wmr[m,r];
            IF single[w] & stable(m,w,r) THEN
                x[m] := w; y[w] := m; single[w] := FALSE;
                Try(m+1);
                single[w] := TRUE
            END
        END
    ELSE
        write
    END
END Try;

PROCEDURE FindStableMarriages;
VAR m, w, r: INTEGER;
BEGIN
    Out.String("Enter men ranks:"); Out.Ln();
    FOR m := 0 TO n-1 DO
        FOR r := 0 TO n-1 DO
            Out.String("["); Out.Int(m, 0); Out.String(", "); Out.Int(r, 0); Out.String("] = ");
            In.Int(wmr[m,r]); rmw[m, wmr[m,r]] := r
        END
    END;

    Out.String("Enter women ranks:"); Out.Ln();
    FOR w := 0 TO n-1 DO
        single[w] := TRUE;
        FOR r := 0 TO n-1 DO
            Out.String("["); Out.Int(w, 0); Out.String(", "); Out.Int(r, 0); Out.String("] = ");
            In.Int(mwr[w,r]); rwm[w, mwr[w,r]] := r
        END
    END;
    Try(0)
END FindStableMarriages;

BEGIN
    FindStableMarriages;
END StableMarriages.
