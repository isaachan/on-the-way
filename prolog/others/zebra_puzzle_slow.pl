:- set_prolog_flag(toplevel_print_options,[quoted(true), portray(true)]).

color([red,yellow,blue,ivory,green]).
nationality([norwegian, ukrainian, english, spaniard, japanese]).
drink([coffee, orange, milk, tea, water]).
smoke([kools, chesterfield, oldglod, lucky, parliament]).
pet([fox, horse, snails, dog, zebra]).

generate(Result) :-
    color(Colors), perm(Colors, PermOfColors),
    nationality(Nats), perm(Nats, PermOfNats),
    drink(Drinks), perm(Drinks, PermOfDrinks),
    smoke(Smokes), perm(Smokes, PermOfSmokes),
    pet(Pets), perm(Pets, PermOfPets),

    generate(Result, PermOfColors, PermOfNats, PermOfDrinks, PermOfSmokes, PermOfPets).
    
generate([], [], [], [], [], []).
generate([[HC,HN,HD,HS,HP]|ResultSoFar], [HC|Colors], [HN|Nats], [HD|Drinks], [HS|Smokes], [HP|Pets]):-
    generate(ResultSoFar, Colors, Nats, Drinks, Smokes, Pets).
    
guess(Result) :-
    get_time(T1), write(T1), nl,

    generate(Result),
    englishLiveInRedRoom(Result),
    spaniardFeedDog(Result),
    greenRoomDrinkCoffee(Result),
    ukrainianDrinkTea(Result),
    greenIsRightSideOfIvory(Result),
    oldGoldFeedSnail(Result),
    koolsInYellow(Result),
    milkInMiddleRoom(Result),
    norwegianLiveInFirstRoom(Result),
    chesterfieldNextToFeedFox(Result),
    koolsNextToFeedHorse(Result),
    lunkyDrinkOrange(Result),
    janpaneseSmokeParliaments(Result),
    norwegianLiveNextToBlueRoom(Result),

    get_time(T2), write(T2), nl.

greenIsRightSideOfIvory([]) :- fail.
greenIsRightSideOfIvory([[ivory|_],[green|_]|_]).
greenIsRightSideOfIvory([_|Rest]) :- greenIsRightSideOfIvory(Rest).

oldGoldFeedSnail([]) :- fail.
oldGoldFeedSnail([[_,_,_,oldglod,snails]|_]).
oldGoldFeedSnail([_|Rest]) :- oldGoldFeedSnail(Rest).

koolsInYellow([]) :- fail.
koolsInYellow([[yellow,_,_,kools,_]|_]).
koolsInYellow([_|Rest]) :- koolsInYellow(Rest).

milkInMiddleRoom([_,_,[_,_,milk,_,_],_,_]).    
milkInMiddleRoom(_) :- fail.

norwegianLiveInFirstRoom([[_,norwegian,_,_,_],_,_,_,_]).
norwegianLiveInFirstRoom(_) :- fail.

chesterfieldNextToFeedFox([]) :- fail.
chesterfieldNextToFeedFox([[_,_,_,_,fox],[_,_,_,chesterfield,_]|_]).
chesterfieldNextToFeedFox([[_,_,_,chesterfield,_],[_,_,_,_,fox]|_]).
chesterfieldNextToFeedFox([_|Rest]) :- chesterfieldNextToFeedFox(Rest).

koolsNextToFeedHorse([]) :- fail.
koolsNextToFeedHorse([[_,_,_,_,horse],[_,_,_,kools,_]|_]).
koolsNextToFeedHorse([[_,_,_,kools,_],[_,_,_,_,horse]|_]).
koolsNextToFeedHorse([_|Rest]) :- koolsNextToFeedHorse(Rest).

lunkyDrinkOrange([]) :- fail.
lunkyDrinkOrange([[_,_,orange,lucky,_]|_]).
lunkyDrinkOrange([_|Rest]) :- lunkyDrinkOrange(Rest).

janpaneseSmokeParliaments([]) :- fail.
janpaneseSmokeParliaments([[_,japanese,_,parliament,_]|_]).
janpaneseSmokeParliaments([_|Rest]) :- janpaneseSmokeParliaments(Rest).

norwegianLiveNextToBlueRoom([]) :- fail.
norwegianLiveNextToBlueRoom([[blue,_,_,_,_], [_,norwegian,_,_,_]|_]).
norwegianLiveNextToBlueRoom([[_,norwegian,_,_,_], [blue,_,_,_,_]|_]).
norwegianLiveNextToBlueRoom([_|Rest]) :- norwegianLiveNextToBlueRoom(Rest).
    
englishLiveInRedRoom([]) :- fail.
englishLiveInRedRoom([[red,english,_,_,_]|_]).
englishLiveInRedRoom([_|Rest]) :- englishLiveInRedRoom(Rest).
    
spaniardFeedDog([]) :- fail.
spaniardFeedDog([[_,spaniard,_,_,dog]|_]).
spaniardFeedDog([_|Rest]) :- spaniardFeedDog(Rest).

greenRoomDrinkCoffee([]) :- fail.
greenRoomDrinkCoffee([[green,_,coffee,_,_]|_]).
greenRoomDrinkCoffee([_|Rest]) :- greenRoomDrinkCoffee(Rest).    

ukrainianDrinkTea([]) :- fail.
ukrainianDrinkTea([[_,ukrainian,tea,_,_]|_]).
ukrainianDrinkTea([_|Rest]) :- ukrainianDrinkTea(Rest).

takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).
perm([X|Y],Z) :- perm(Y,W), takeout(X,Z,W).
perm([],[]).    

