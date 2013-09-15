%Satelite old_version_asp

#hide.
#show pointing(S,D,T),turn_to(S,D1,D2,T),have_image(D,T),take_image(S,D,I,T),mode(I,X,T).


#domain satelite(S),instrument(I),direction(D), dom(X,Y),time(T),counter(C).
time(1..4).
counter(0..10).

%defining state variables and their domains
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
memory(0,1).

%goal state
goal(T):-have_image(phenomenon1,T),have_image(phenomenon2,T), have_image(star1,T).
goal(T+1):- goal(T).
g :- goal(T).
compute 1{g}.

%------------------------------------------------------------
%actions
%------------------------------------------------------------

%taking picture
{take_image(S,D,I,T)}:-pointing(S,D,T),not goal(T),mode(I,ready,T),not mode(I,saving,T).
mode(I,saving,T+1):-take_image(S,D,I,T).
have_image(D,T+1):-take_image(S,D,I,T).

image(D,T+1):-take_image(S,D,I,T).
saved(I,T) :- mode(I,saving,T).

% defining modes of a camera
{mode(I,ready,T+1)}:-saved(I,T).
{mode(I,ready,T+1)}:-mode(I,ready,T), not take_image(S,D,I,T).
mode(I,saving,T) :- not mode(I,ready,T).
mode(I,ready,T) :- not mode(I,saving,T).
have_image(D,T+1):-have_image(D,T),not goal(T).

% changing the direction of the satelite
{turn_to(S,D1,D2,T)}:-direction(D1),direction(D2),pointing(S,D1,T), D1!=D2,not goal(T).
pointing(S,D2,T+1):- turn_to(S,D1,D2,T),pointing(S,D1,T),direction(D1),direction(D2), D1 != D2.
:-pointing(S,D1,T),pointing(S,D2,T),direction(D1),direction(D2),D1!=D2.

memory(C,T):-C{image(D,T)}C.




