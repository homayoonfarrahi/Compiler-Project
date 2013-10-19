//Define a grammar called mol

grammar mol;


//s	:	program ;


program	:	(module)* {System.out.println("Rule1");} ;



module	:	tempId1=ID ('extends' tempId2=ID)? '{' (member)* '}' {System.out.print("Rule2 " + $tempId1.text);                                                                                                            if ($tempId2==null) System.out.println();                                                                                                              else System.out.println(" : " + $tempId2.text);} ;



member	:	tempId=ID '(' ( ID('[]')? ':' type ( ','ID('[]')? ':' type  )* )?  ')' ':' type block {System.out.println("Rule3 " + $tempId.text);}
		
		| vardecl';' {System.out.println("Rule4");}
		;



type	:	(ID | 'int' | 'bool' | 'void') {System.out.println("Rule5");} ;



vardecl	:	ID ('['CONSTINT']')? (','ID ('['CONSTINT']')?)* ':' (type | cons) {System.out.println("Rule6");} ;



cons	:	ID'(' expr (','expr)* ')' {System.out.println("Rule7");} ; 		//TODO: CONS RULE IS AMBIGIOUS IN THE PROBLEM DESCRIPTION



block	:	'{' (st)* '}' {System.out.println("Rule8");} ;			//TODO: TO BE CHANGED WITH STATEMENT WHEN APPROPRIATE



st	:	block {System.out.println("Rule9");}

		
		| vardecl ';' {System.out.println("Rule10");}
		
		| methodcall ';' {System.out.println("Rule11");}
		
		| 'if' expr 'then' st ('else' st)* {System.out.println("Rule12");}
		
		| 'while' expr 'do' st {System.out.println("Rule13");}
		
		| loc ':=' expr ';' {System.out.println("Rule14");}
		
		| 'return' expr ';' {System.out.println("Rule15");}
		
		| ('break' | 'continue') ';' {System.out.println("Rule16");}
		
		| ('read' ID | 'write' expr) ';' {System.out.println("Rule17");}
		;



loc	:	ID ('['expr']')? {System.out.println("Rule18");}
		
		| ID ('['expr']')? '.' loc {System.out.println("Rule19");}
		
		| ID'(' (expr (','expr)*)? ')' '.' loc {System.out.println("Rule20");}
		
		| 'self' '.' loc {System.out.println("Rule21");}
		;



methodcall:	(loc'.')? ID'(' (expr (','expr)*)? ')' {System.out.println("Rule22");} ;



expr	:	exprOr ;



exprOr	:	exprAnd ('or' {System.out.println("Rule31 or");} exprAnd {System.out.println("Rule29");} )* ;



exprAnd	:	exprEqual ('and' {System.out.println("Rule31 and");} exprEqual {System.out.println("Rule29");} )* ;



exprEqual:	exprRel ( ('=' {System.out.println("Rule31 =");} |
			   '!=' {System.out.println("Rule31 !=");} ) exprRel {System.out.println("Rule29");} )* ;



exprRel	:	exprAdd ( ('<' {System.out.println("Rule31 <");} |
			   '>' {System.out.println("Rule31 >");} |
			   '<=' {System.out.println("Rule31 <=");} |
			   '>=' {System.out.println("Rule31 >=");} ) exprAdd {System.out.println("Rule29");} )* ;



exprAdd	:	exprMult ( ('+' {System.out.println("Rule31 +");} | 
			    '-' {System.out.println("Rule31 -");} ) exprMult {System.out.println("Rule29");} )* ;



exprMult:	exprMinus ( ('*' {System.out.println("Rule31 *");} | 
			     '/' {System.out.println("Rule31 /");} ) exprMinus {System.out.println("Rule29");} )* ;



exprMinus:	'-'<assoc=right> {System.out.println("Rule32 -");} exprMinus {System.out.println("Rule30");}	//<assoc> PUT NEWLY: NOT TESTED
		| exprParen
		;



exprParen:	'(' expr ')' {System.out.println("Rule27");} 
		| exprFinal
		;



exprFinal:	loc {System.out.println("Rule23");}
		
		| 'self' {System.out.println("Rule24");}
		
		| methodcall {System.out.println("Rule25");}
		
		| cons {System.out.println("Rule26");}
		
		| (CONSTINT | CONSTBOOL) {System.out.println("Rule28");}

		| 'not'<assoc=right> {System.out.println("Rule32 not");} exprEqual {System.out.println("Rule30");}  //NOT IS HERE BECASE IT'S UNARY
		;



CONSTINT:	([1-9][0-9]* | '0') ;			//TODO: NOT TESTED



CONSTBOOL:	'true' | 'false' ;			//TODO: NOT TESTED
		


ID	:	[a-zA-Z][a-zA-Z0-9]* ;			//TODO: MUST EXCLUDE KEYWORDS FROM IT



LINE_COMMENT:	'%%' .*? '\r'? '\n' -> skip ;
COMMENT	:	'%%%' .*? ('%%%' | EOF) -> skip ;



WS	:	[ \t\r\n]+ -> skip ;
