:- set_prolog_flag(toplevel_print_options,[quoted(true), portray(true)]).

:- ['date.pl'].
:- ['subject.pl'].

training(Days, Num) :-
    get_time(T1), write(T1), nl,
    generate(Days1, Num),
    reverse(Days, Days1),
    
    findall(Subject, subject_detail(Subject, _, _), Subjects),
    sufficientClasses(Days, Subjects),    
    get_time(T2), write(T2), nl.

sufficientClasses(_, []) :- !.
sufficientClasses(Days, [FirstSubject|Rest]) :-
    subject_detail(FirstSubject, Classes, [ExamH|ExamR]),
    sufficientClassesForSubject(Days, [ExamH|ExamR], FirstSubject, Classes, 0),
    sufficientClasses(Days, Rest).
      
sufficientClassesForSubject(_, [], _, _, _) :- !.
        
sufficientClassesForSubject(Days, [ExamH|ExamR], Subject, Classes, LastExam) :-
    subset(Days, LastExam, ExamH, Period),
    occurrences(Period, Subject, Classes),
    sufficientClassesForSubject(Days, ExamR, Subject, Classes, ExamH).

generate(Days, Length) :- length(Days, Length), generate(Days).
generate([]).
generate([[n,n]|RestDays]) :- generate(RestDays).
generate([[Subject1,Subject2]|RestDays]) :- subject(Subject1), subject(Subject2), Subject1 \= Subject2, generate(RestDays).

occurrences([],_,0) :- !.
occurrences([X|Y],S,N) :- member(S,X), occurrences(Y,S,W),N is W + 1.
occurrences([X|Y],S,N) :- not(member(S,X)), occurrences(Y,S,N).
    
subset(S, From, End, R) :- subset(S, From, End, [], R), !.
subset(_, 0, 0, R, R) :- !.
subset([H|SL], 0, End, R, Final) :- End1 is End - 1, subset(SL, 0, End1, [H|R], Final).
subset([_|SL], From, End, R, Final) :- From1 is From - 1, End1 is End - 1, subset(SL, From1, End1, R, Final).
