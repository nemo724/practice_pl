% ?- write("Hello, new sekai").
male('bob').%밥은 남자이다
male('john').%존은 남자이다
female('alice').%앨리스는 여자이다  
female('carol').%캐럴은 여자이다 

% 2항 관계 child.  원소나열법 표현
child('bob', 'alice').%밥은 앨리스의 자식이다
child('carol', 'alice').%캐럴은 앨리스의 자식이다
child('bob', 'john').%밥은 존의 자식이다   
child('carol', 'john').%캐럴은 존의 자식이다

%요약: 부:존 모:앨리스 장자:밥 장녀:캐럴 

% 2항 관계 son
son(X, Y) :- child(X, Y), male(X). %아들이란 X가 Y의 자식이고, X는 남자이다
?- findall( (X,Y), son(X, Y) , Bag ),
forall( member((X,Y), Bag), format("son: X = ~w, Y = ~w~n", [X, Y]) ).