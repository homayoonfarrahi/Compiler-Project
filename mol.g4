//Define a grammar called mol

grammar mol;


s	:	expr ;


program	:	(module)* {System.out.println("Rule1");} ;



module	:	tempId1=ID ('extends' tempId2=ID)? '{' (member)* '}' {System.out.print("Rule2 " + $tempId1.text);                                                                                                            if ($tempId2==null) System.out.println();                                                                                                              else System.out.println(" : " + $tempId2.text);} ;



member	:	tempId=ID '(' ( ID('[]')? ':' type ( ','ID('[]')? ':' type  )* )?  ')' ':' type block {System.out.println("Rule3 " + $tempId.text);}
		
		| vardecl';' {System.out.println("Rule4");}
		;



type	:	(ID | 'int' | 'bool' | 'void') {System.out.println("Rule5");} ;



vardecl	:	ID ('['CONSTINT']')? (','ID ('['CONSTINT']')?)* ':' (type | cons) {System.out.println("Rule6");} ;



cons	:	ID'(' expr (','expr)* ')' {System.out.println("Rule7");} ; 		//TODO: CONS RULE IS AMBIGIOUS IN THE PROBLEM DESCRIPTION



block	:	'{'  '}' {System.out.println("Rule8");} ;			//TODO: TO BE CHANGED WITH STATEMENT WHEN APPROPRIATE



loc	:	ID ('['expr']')? {System.out.println("Rule18");}
		
		| ID ('['expr']')? '.' loc {System.out.println("Rule19");}
		
		| ID'(' (expr (','expr)*)? ')' '.' loc {System.out.println("Rule20");}
		
		| 'self' '.' loc {System.out.println("Rule21");}
		;



methodcall:	(loc'.')? ID'(' (expr (','expr)*)? ')' {System.out.println("Rule22");} ;



expr	:	loc {System.out.println("Rule23");}
		
		| 'self' {System.out.println("Rule24");}
		
		| methodcall {System.out.println("Rule25");}
		
		| cons {System.out.println("Rule26");}
		
		| '(' expr ')' {System.out.println("Rule27");}
		
		| (CONSTINT | CONSTBOOL) {System.out.println("Rule28");}
		
		| '-'<assoc=right> expr {System.out.println("Rule32 -\r\nRule30");}
		
		| expr (temp='*'<assoc=left> | temp='/'<assoc=left>) {System.out.println("Rule31 " + $temp.text);} expr {System.out.println("Rule29");}
		
		| expr (temp='+'<assoc=left> | temp='-'<assoc=left>) expr {System.out.println("Rule31 " + $temp.text + "\r\nRule29");}
		
		| expr (temp='<'<assoc=left> {System.out.println("Rule29\r\nRule31 <");}                                                                                          | temp='>'<assoc=left> {System.out.println("Rule29\r\nRule31 >");}                                                                                          | temp='<='<assoc=left> {System.out.println("Rule29\r\nRule31 <=");}                                                                                        | temp='>='<assoc=left> {System.out.println("Rule29\r\nRule31 >=");}) expr
		
		| expr ('='<assoc=left> {System.out.println("Rule29\r\nRule31 =");}                                                                                          | '!='<assoc=left> {System.out.println("Rule29\r\nRule31 !=");}) expr
		
		| 'not'<assoc=right> expr {System.out.println("Rule30\r\nRule32 not");}
		
		| expr 'and'<assoc=left> expr {System.out.println("Rule29\r\nRule31 and");}
		
		| expr 'or'<assoc=left> expr {System.out.println("Rule29\r\nRule31 or");}
		;



CONSTINT:	([1-9][0-9]* | '0') ;			//TODO: NOT TESTED



CONSTBOOL:	'true' | 'false' ;			//TODO: NOT TESTED
		


//ID	:	^((?!^true$)(?!^false$)[a-zA-z]\w*)$ ;
ID	:	[a-zA-Z][a-zA-Z0-9]* ;			//TODO: MUST EXCLUDE KEYWORDS FROM IT



WS	:	[ \t\r\n]+ -> skip ;
