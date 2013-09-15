% PSR asp old_version

#hide.
#show in(L,safe,T),on(userdevice,D,T+1),off(userdevice,D,T+1),status(D,M,T).

#domain time(T),mode(M),signal(Sig),connected(D1,D2,L),device(D),device(D1),device(D2),line(L).

%defining  the objects
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

%connected(from,to,by)
connected(sd1,sd3,l13).
connected(sd3,userdevice,l3u).
connected(sd2,userdevice,l2u).
connected(pw,sd1,lp1).
connected(pw,sd2,lp2).

signal(faulty).
signal(safe).




%-------------------------------------------------------
%initializing

%status(sd1,open,1).
%status(sd2,close,1).
%status(pw,open,1).

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



%for the lines not connected to the powersource
in(L,safe,T):-connected(D1,D2,L), status(D1,open,T),in(L1,safe,T),connected(D3,D1,L1), L1!=L,line(L1).
on(userdevice,D,T+1):- status(D,open,T),connected(D,userdevice,L),in(L,safe,T).
off(userdevice,D,T+1):- status(D,close,T),connected(D,userdevice,L).



