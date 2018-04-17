MODULE BalancedTree;

IMPORT In, Out;

TYPE 
  Node = POINTER TO NodeDesc;
  NodeDesc = RECORD 
    key: INTEGER;
    left, right: Node
  END;

PROCEDURE tree(n: INTEGER): Node;
VAR
  new: Node;
  x, nl, nr: INTEGER;
BEGIN
    IF n = 0 THEN 
      new := NIL
    ELSE 
      nl := n DIV 2;
      nr := n - nl - 1;
      NEW(new); 
      In.Int(x);
      new.key := x;
      new.left := tree(nl);
      new.right := tree(nr);
    END;
    RETURN new
END tree;

PROCEDURE PrintTree(t: Node; h: INTEGER);
VAR i: INTEGER;
BEGIN
    IF t # NIL THEN
      PrintTree(t.left, h + 1);
      FOR i := 1 TO h DO
        Out.String("    ")
      END;
      Out.Int(t.key, 6);
      Out.Ln();
      PrintTree(t.right, h + 1)
    END
END PrintTree;

VAR root: Node;

BEGIN
    root := tree(21);
    PrintTree(root, 1);
END BalancedTree.
