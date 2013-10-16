//Define a test grammar called mol

grammar mol;

r	:	'hello' ID  { System.out.println("Rule 1"); } ;

ID	:	[a-z]+  { System.out.println("Rule 2"); } ;

WS	:	[ \t\r\n]+ -> skip ;
