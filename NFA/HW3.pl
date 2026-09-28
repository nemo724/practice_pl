%ε전이들로 이루어진 cycle이 있는 NFA에서 문자열 인식
% q2 -> q3 간의 엡실론 무한 루프에 빠지는 것을 방지해야함
% ε이 있는 NFA에서 문자열 인식
% NFA M3 = ({q1,q2,q3,q4}, {0,1,ε}, δ, q1, q4)


:- table recog_chars/2. % Prolog의 테이블링 기능을 이용하여 q2,q3간 ε 무한루프를 방지
state([q1,q2,q3,q4]). % Q = {q1,q2,q3,q4}

delta(q1,'0',q1). delta(q1,'1',q1). delta(q1,'1',q2). % δ(q1,{1,0}) = {q1,q2}
delta(q2,'0',q3). delta(q2,'',q3). % δ(q2,{0,ε}) = {q3}, ε = '' 
delta(q3,'1',q4). delta(q3,'',q2).% δ(q3,{1,ε}) = {q2,q4}
delta(q4,'0',q4). delta(q4,'1',q4). % δ(q4,{0,1}) = {q4}

start(q1). % 초기상태 의미
final([q4]). % 수용상태 의미, 수용상태는 여러 개 존재 가능하므로 []로 표현

recognize(Str) :- atom_chars(Str,CS), start(Q), recog_chars(CS,Q). 
% 문자열 입력 = 문자열을 쪼개고 시작을 Q에서 쪼갠 문자열과 시작 상태에 넣고 δ(Q,Str[0])확인 

recog_chars([],Q) :- final(Finals), member(Q,Finals).
% 입력이 모두 소모되고 현재 내부상태에 위치가 승인상태인지 확인
% final(Finals)로 승인상태 집합(=F)을 가져오고, 내장술어 member로 현재상태 Q가 Q∈F확인

recog_chars([C|CS],Q) :- delta(Q,C,Next), recog_chars(CS, Next).
% δ(Q,0)와 δ(Q,1)을 실행 시켜 유효한 다음 내부상태 qn을 찾고 다음 내부상태와 소모되고 남은입력으로 재귀탐색
% 찾지 못한다는건 유효 입력이 아니거나 수용하지 않는 문자열이라는 의미 

recog_chars(CS,Q) :- delta(Q,'',Next), recog_chars(CS, Next).
% δ(Q,ε) = {∅}이면  False로 불가능하지만 δ(Q,ε) != {∅}인 경우 true로 백트래킹 가능, δ(q2,{0,ε}) = {q3}

?- recognize('101') -> format('101은 허용됩니다~n'); format('101은 거절됩니다~n'). % 허용
?- recognize('11') -> format('11은 허용됩니다~n'); format('11은 거절됩니다~n'). % 허용
?- recognize('000100') -> format('000100은 허용됩니다~n'); format('000100은 거절됩니다~n'). %거절