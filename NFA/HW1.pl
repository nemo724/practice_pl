% ε이 없는 NFA에서 문자열 인식
?- atom_chars('abac' , CS), %R(A,B).일때 시퀀스 A를 분할하여 B에 리스트 형태로 넣음  
atom_chars(Str,['a','b','a','c']),%Prolog의 역연산을 이용하여 그 반대도 가능
format('atom_chars 실행 예시 ~w ~w ~n ', [CS, Str]).

% NFA M = ({q1,q2,q3,q4}, {0,1}, δ, q1, q4)
state([q1,q2,q3,q4]). % Q = {q1,q2,q3,q4}를 의미 q1='q1'으로 '없이도 사용가능


delta(q1,'0',q1). delta(q1,'1',q1). delta(q1,'1',q2). % δ(q1,{1,0}) = {q1,q2}
delta(q2,'0',q3). delta(q2,'1',q3).  % δ(q2,{1,0}) = {q3}
delta(q3,'0',q4). delta(q3,'1',q4).  % δ(q3,{1,0}) = {q4}

start(q1). % 초기상태 의미
final([q4]). % 수용상태 의미, 수용상태는 여러 개 존재 가능하므로 []로 표현

recognize(Str) :- atom_chars(Str,CS), start(Q), recog_chars(CS,Q). 
% 문자열 입력 = 문자열을 쪼개고 시작을 Q에서 쪼갠 문자열과 시작 상태에 넣고 δ(Q,Str[0])확인 

recog_chars([],Q) :- final(Finals), member(Q,Finals).
% 입력이 모두 소모되고 현재 내부상태에 위치가 승인상태인지 확인
% final(Finals)로 승인상태 집합(=F)을 가져오고, 내장술어 member로 현재상태 Q가 Q∈F확인

recog_chars([C|CS],Q) :- delta(Q,C,Next), recog_chars(CS, Next).
% δ(Q,0)와 δ(Q,1)을 실행 시켜 유효한 다음 내부상태 qn을 찾고 다음 내부상태와 소모되고 남은입력으 재귀탐색
% 찾지 못한다는건 유효입력이 아니거나 수용하지 않는 문자열이라는 의미 

?- recognize('100') -> format('100은 허용됩니다~n'); format('100은 거절됩니다~n').
?- recognize('0011') -> format('0011은 허용됩니다~n'); format('0011은 거절됩니다~n').
?- recognize('000100') -> format('000100은 허용됩니다~n'); format('000100은 거절됩니다~n').