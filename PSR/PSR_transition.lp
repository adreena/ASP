% PSR new version ASP+SASE
#hide.
#show transition(D,status(D,M1,T),status(D,M2,T+1),T), in(L,Sig,T),status(D,M,T).
#domain time(T),mode(M),current(N),signal(Sig),connected(D1,D2,L),device(D),device(D1),device(D2),line(L).

%defining state variables
device(sd1). 
device(sd2).
device(sd3). 
device(pw).
device(userdevice).
line(l13). 
line(l3u). 
line(l2u). 
line(lp1).
line(lp2).

time(1..2).
mode(open). 
mode(close).
current(off).
current(on).

%connected(from,to,by)
connected(sd1,sd3,l13).
connected(sd3,userdevice,l3u).
connected(sd2,userdevice,l2u).
connected(pw,sd1,lp1).
connected(pw,sd2,lp2).


signal(faulty).
signal(safe).

%transitions
transition(D,status(D,M1,T),status(D,M2,T+1),T):-status(D,M1,T),status(D,M2,T+1),mode(M1),mode(M2),D!=userdevice.
transition(userdevice,u_status(userdevice,N1,T),u_status(userdevice,N2,T+1),T):- u_status(userdevice,N1,T),u_status(userdevice,N2,T+1),current(N1),current(N2).
transition(L,in(L,Sig,T),in(L,Sig2,T+1),T):-in(L,Sig,T),in(L,Sig2,T+1),signal(Sig2).




%-------------------------------------------------------
%initializing


in(lp1,faulty,1).
in(lp2,safe,1).




%goal
goal(T):-on(userdevice,D,T).
goal(T+1):-goal(T).
g :- goal(T).
compute 1 { g }.
%--------------------------------------------------------

{in(L,Sig,T)}:-connected(pw,D,L).
:-in(L,faulty,T),in(L,safe,T).


closing(D,T):-in(L,faulty,T),connected(D1,D,L).
opening(D,T):-in(L,safe,T),connected(D1,D,L).
:-opening(D,T),closing(D,T).
status(D,close,T):-closing(D,T).
status(D,close,T):- status(D,close,T),not opening(D,T).
status(D,open,T):- opening(D,T).
status(D,open,T):- status(D,open,T),not closing(D,T).
status(pw,open,T):-status(pw,open,T).

status(D,close,T):-status(D1,close,T),connected(D1,D,L), D!=pw, D!=userdevice.

u_status(userdevice,off,T):-status(userdevice,close,T).
u_status(userdevice,on,T):-status(userdevice,open,T).

%for the lines not connected to the powersource
in(L,safe,T):-connected(D1,D2,L), status(D1,open,T),in(L1,safe,T),connected(D3,D1,L1), L1!=L,line(L1).
on(userdevice,D,T+1):- status(D,open,T),connected(D,userdevice,L),in(L,safe,T).
off(userdevice,D,T+1):- status(D,close,T),connected(D,userdevice,L).



