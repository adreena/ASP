%Code block-wolrd old_version ASP

d(a).
d(b).
d(c).
st(initial).
st(process).
st(goal).
#domain time(T),st(S), d(X), d(Y),d(Z), dom(X,P1),dom(X,P2),dom(X,P).
#hide.
#show move(X,Y,T).


counter(1..10).

% initializing
clr(a,1).
clr(b,1).
clr(table,1).
time(1..3).

dom(a,b).
dom(a,c).
dom(a,table).
dom(b,a).
dom(b,c).
dom(b,table).
dom(c,a).
dom(c,b).
dom(c,table). 

pos(b,table,1).
pos(a,table,1).
pos(c,table,1).

goal(T):- pos(a,c,T),pos(b,a,T).



% defining the actions
{move(X,Y,T)}:- clr(X,T),clr(Y,T),dom(X,Y),not affected(Y,T), not goal(T).
{move(X,table,T)}:-clr(X,T), not goal(T).
:-affected(table,T).
:-move(X,table,T),pos(X,table,T).
:-move(X,Y,T), move(X,Z,T), Y!=Z .
affected(X,T) :- move(X,Y,T).
affected(X,T):- move(X,table,T).
pos(X,P,T+1):-move(X,P,T),dom(X,P).
pos(X,P2,T+1) :- pos(X,P2,T),not affected(X,T),dom(X,P2).
covered(X,T) :- pos(Z,X,T),dom(Z,X).
clr(X,T):-not covered(X,T).
clr(table,T+1) :- clr(table,T).
pos(X,Y,T+1) :-move(X,Y,T).
%-----------------------------------------------------------------------



goal(T+1) :- goal(T).
g :- goal(T).
compute 1 { g }.






