// Simple grammar to test on

grammar simple;

prog: declaration +;

declaration: programdecl | verbdecl | propertydecl | rmpropertydecl | setpropertydecl | displaypropertydecl | kidsdecl | parentdecl | describedecl | contentsdecl | noteditdecl | createdecl | editdecl | addaliasdecl ;

programdecl : '@program' programname ':' name statement + '.'   ;

programname   : name   | stringliteral   ;

verbdecl   : '@verb' (verbname ':' name) name + permissions?   ;

verbname   : name   | stringliteral   ;

propertydecl   : ('@property' | '@prop') property_ '='? expression? permissions?   ;

rmpropertydecl   : ('@rmproperty' | '@rmprop') name   ;

setpropertydecl   : '@set' property_ 'to' expression   ;

displaypropertydecl   : ('@display' | '@disp') property_   ;

kidsdecl   : '@kids' name   ;

parentdecl   : '@parent' name   ;

describedecl   : '@describe' property_ 'as' expression   ;

contentsdecl   : '@contents' name   ;

noteditdecl   : '@notedit' property_   ;

createdecl   : '@create' sysname 'called' expressionlist   ;

editdecl   : '@edit' property_   ;

addaliasdecl   : '@addalias' name (',' name)* 'to' expression   ;

statement   : ifblock   | whileblock   | doblock   | forblock   | assignblock   | tryblock   | command SEMICOLON   ;