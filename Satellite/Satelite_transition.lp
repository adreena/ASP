%Satelite in ASP+sasE new version
#hide.

#show transition(S,dir(S,D1,T),dir(S,D2,T+1),T),transitions(I,mode(I,saving,T),mode(I,ready,T+1),T).

#domain satelite(S),instrument(I),direction(D), dom(X,Y),time(T),counter(C).
time(1..5).
counter(0..10).

%defining the transitions
transition(S,dir(S,D1,T),dir(S,D2,T+1),T):-turn_to(S,D1,D2,T),direction(D1),direction(D2).
transition(S,dir(S,D1,T),dir(S,D2,T+1),T):-turn_to(S,D1,D2,T),direction(D1),direction(D2), D1== D2.

pointing(S,D2,T+1) :-transition(S,dir(S,D1,T),dir(S,D2,T+1),T),direction(D1),direction(D2).
transition(S,dir(S,D,T),dir(S,D,T+1),T):-take_image(S,D,I,T).

transitions(I,mode(I,saving,T),mode(I,ready,T+1),T):-mode(I,saving,T),mode(I,ready,T+1).
transitions(I,mode(I,ready,T),mode(I,saving,T+1),T):-mode(I,ready,T),mode(I,saving,T+1).
transitions(I,mode(I,ready,T),mode(I,ready,T+1),T):-mode(I,ready,T),mode(I,ready,T+1).
transitions(I,mode(I,saving,T),mode(I,saving,T+1),T):-mode(I,saving,T),mode(I,saving,T+1).

%defining the State Vairables and domains
satelite(sat).
instrument(camera1).
instrument(camera2).

direction(phenomenon1).
direction(phenomenon2).
direction(star1).


%initial state
pointing(sat,star1,1).
mode(camera1,ready,1).
mode(camera2,ready,1).


%goal state
goal(T):-have_image(phenomenon1,T),have_image(phenomenon2,T).
goal(T+1):- goal(T).
g :- goal(T).
compute 1{g}.

%----------------------------------------------------------------
%supporting actions
%----------------------------------------------------------------
%taking image
{take_image(S,D,I,T)}:-pointing(S,D,T),not goal(T),mode(I,ready,T),not mode(I,saving,T).
mode(I,saving,T+1):-take_image(S,D,I,T).
have_image(D,T+1):-take_image(S,D,I,T).

image(D,T+1):-take_image(S,D,I,T).
saved(I,T+1) :- mode(I,saving,T+1).

%defining the modes of camera
{mode(I,ready,T+1)}:-saved(I,T).
{mode(I,ready,T+1)}:-mode(I,ready,T), not take_image(S,D,I,T).
mode(I,saving,T) :- not mode(I,ready,T).
mode(I,ready,T) :- not mode(I,saving,T).
have_image(D,T+1):-have_image(D,T),not goal(T).

%changing the direction of statellite
{turn_to(S,D1,D2,T)}:-direction(D1),direction(D2),pointing(S,D1,T), D1!=D2,not goal(T).
:-pointing(S,D1,T),pointing(S,D2,T),direction(D1),direction(D2),D1!=D2.



