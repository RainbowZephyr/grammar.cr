grammar avro_grammar;


s: '{'('\n')*'"namespace": "ritec.webserver.pojo",\n"type": ' type ',\n' '"name": ' NAME ',\n"fields": [\n' fields '\n]\n}';
type: '"null"' (', ' type)* | '"boolean"' (', ' type)* | '"int"' (', ' type)* | '"long"' (', ' type)* | '"float"' (', ' type)* | '"double"' (', ' type)* | '"bytes"' (', ' type)* | '"string"' (', ' type)* | '"record"' (', ' type)* | '"enum"' (', ' type)* | '{\n"type": "array",\n"items": ' type '}'(', ' type)* | '"map"' (', ' type)* | '"fixed"' (', ' type)* | '"LongList"' (', ' type)* | '[' type ']' | fields | ;
fields: '{\n"name"'SPACE*':' SPACE* NAME SPACE* ',' SPACE* '"type": ' type ('\n}')* (',\n' fields)* | '\n"fields": [\n' fields '\n]\n}' | '{\n"type": ' type ('\n}')* (',\n' fields)* | ;
NAME: '"'[a-zA-Z0-9_]+'"';
SPACE: [ \t\r\n]+;

//s: '{'('\n')*'"namespace": "ritec.webserver.pojo",\n"type": ' type ',\n' '"name": ' name ',\n'
//    '"aliases": ["LinkedLongs"],\n"fields": [\n' fields '\n]\n}';
//type: '"null"' (', ' type)* | '"boolean"' (', ' type)* | '"int"' (', ' type)* | '"long"' (', ' type)* | '"float"' (', ' type)* | '"double"' (', ' type)* | '"bytes"' (', ' type)* | '"string"' (', ' type)* | '"record"' (', ' type)* | '"enum"' (', ' type)* | '"array"' (', ' type)* | '"map"' (', ' type)* | '"fixed"' (', ' type)* | '"LongList"' (', ' type)* | '[' type ']' | ;
//fields: '{"name": ' name ', "type": ' type '}' (',\n' fields)* | ;
//name: '"value"' | '"next"' | '"LongList"' | '"HistoryResponse"';

//n0: 'double' n1 n2;
//r1: 'string' r1 | ;
//n1: '[' r1 ']';
//r2: n3 r2 | ;
//n2: '{' r2 '}';
//u3: '1' 'null' | '2' n4 | '3' n0;
//n3: 'union' u3;
//r4: 'bytes' r4 | ;
//n4: '[' r4 ']';
