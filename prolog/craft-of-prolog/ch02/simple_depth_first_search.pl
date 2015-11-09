start(a).

child(a, b).
child(a, c).
child(b, d).
child(b, e).
child(d, h).
child(d, i).
child(e, j).
child(e, k).
child(c, f).
child(c, g).
child(f, l).
child(f, m).
child(g, n).
child(g, o).

solution(a).
solution(b).
solution(c).
solution(d).
solution(e).
solution(f).
solution(g).
solution(h).
solution(i).
solution(j).
solution(k).
solution(l).
solution(m).
solution(n).
solution(o).

%%
%% Version 1
%%
answer(Y) :-
	start(X),
	child_star(X, Y),
	solution(Y).

child_star(X, X).
child_star(X, Z) :-
	child(X, Y),
	child_star(Y, Z).


%%
%% Depth-First Search
%%
children(Parent, Children) :-
	findall(Child, child(Parent, Child), Children).

depth_first(Answer) :-
	start(Start),
        depth_star([Start], Answer),
	solution(Answer).

depth_star([X|_], X).
depth_star([X|Open], Y) :-
	children(X, Children),
	append(Children, Open, Open1),
	depth_star(Open1, Y).


%%
%% Breadth-First Search
%%
breadth_first_1(Answer) :-
	start(Start),
	breadth_star_1([Start], Answer),
	solution(Answer).

breadth_star_1([X|_], X).
breadth_star_1([X|Open], Y) :-
	children(X, Children),
	append(Open, Children, Open1),
	breadth_star_1(Open1, Y).

	


        