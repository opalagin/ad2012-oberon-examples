MODULE TopSort;

IMPORT In, Out;

TYPE 
  Leader = POINTER TO LeaderDesc;
  Trailer = POINTER TO TrailerDesc;
  LeaderDesc = RECORD 
    key, count: INTEGER;
    trail: Trailer; next: Leader
  END;
  TrailerDesc = RECORD 
    id: Leader; next: Trailer 
  END;

VAR head, tail: Leader; n: INTEGER;

PROCEDURE find(w: INTEGER): Leader;
  VAR h: Leader;
BEGIN
    h := head; 
    tail.key := w;
    WHILE h.key # w DO 
      h := h.next 
    END;
    IF h = tail THEN
      NEW(tail); 
      INC(n);
      h.count := 0; 
      h.trail := NIL; 
      h.next := tail
    END;
    RETURN h
END find;

PROCEDURE TopSort;
VAR p, q: Leader; t: Trailer;
    x, y: INTEGER;
BEGIN
  NEW(head); 
  tail := head; 
  n := 0;

  In.Int(x);
  WHILE x > 0 DO
    In.Int(y); 
    p := find(x); 
    q := find(y);
    NEW(t); 
    t.id := q; 
    t.next := p.trail;
    p.trail := t; 
    INC(q.count); 
    
    In.Int(x)
  END;

  p := head; 
  head := NIL;
  WHILE p # tail DO
    q := p; 
    p := q.next;
    IF q.count = 0 THEN
      q.next := head; 
      head := q
    END
  END;

  q := head;
  WHILE q # NIL DO
    Out.Ln(); 
    Out.Int(q.key, 8); 
    DEC(n);
    t := q.trail; 
    q := q.next;
    WHILE t # NIL DO
      p := t.id; 
      DEC(p.count);
      IF p.count = 0 THEN
        p.next := q; 
        q := p
      END;
      t := t.next
    END
  END;

  IF n # 0 THEN
    Out.String("Invalid set")
  END;
  Out.Ln()
END TopSort;

BEGIN
  TopSort
END TopSort.
