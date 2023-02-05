# YACC-to-generate-DAG-for-expression-grammar

Algorithm to construct DAG :
	
Ex:)	(1) a = b op c
		    (2) a = op b
		    (3) a = b
Steps:
  (i)	If b operand is not defined, then create a node(b). If c operand is not defined, the create a node for case(1) as node(c).
  (ii)	Create node(op) for case(1), with node(c) as its right child and node(op) as its left child(b).
  (iii)	For the case(2), see if there is node operator(op) with one child(b). Node n will be node(b) in case(3).
  (iv)	Remove a from the list of node identifiers. Step(ii): Add a to the list of attached identifiers for node n.
