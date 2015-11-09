%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reduce version 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
reduce([]).

reduce([{X}|T]) :-
    call(X),
    !,
    reduce(T).

reduce([Lhs|T]) :-
    eqn(Lhs, Rhs),
    append(Rhs, T, T1),
    !,
    reduce(T1).

eqn(fact(0,1), []).
eqn(fact(N,F), [{N1 is N-1}, fact(N1,F1), {F is F1*N}]).

eqn(nrev([H|T], Z), [nrev(T, T1), concat(T1, [H], Z)]).
eqn(nrev([],[]), []).

eqn(concat([H|T], T1, [H|T2]), [concat(T, T1, T2)]).
eqn(concat([], T, T), []).

% reduce([fact(3,F), {write(result(F)), nl}]).
% reduce([nrev([a,b,c], R), {write(result(R)), nl}]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reduce version 2
%  it always terminate before a fix
%  number of reductions has been
%  performed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
reduce([], N, terminated(N)) :- !.
reduce(Goals, 20, continuation(Goals)) :- !.

reduce([{X}|T], N, Result) :-
    call(X), !,
    N1 is N+1,
    reduce(T, N1, Result).

reduce([Lhs|T], N, Result) :-
    eqn(Lhs, Rhs),
    append(Rhs, T, T1),
    N1 is N+1,
    reduce(T1, N1, Result).

% reduce([nrev([a,b,c,d], R), {write(R), nl}], 0, Result), write(Result).
% reduce([nrev([a,b,c,d,e], R), {write(R), nl}], 0, Result), write(Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  multi_reduce
%    A multi task scheduler.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

multi_reduce([]) :- !.
    
multi_reduce([job(N, Goals)|T]) :-
    write(staring(N)), nl,
    reduce(Goals, 0, Result),
    multi_reduce(Result, N, T).

multi_reduce(continuation(Goals), N, Job_Queue) :-
    write(suspending(N)), nl,
    append(Job_Queue, [job(N, Goals)], T1),
    multi_reduce(T1), !.

multi_reduce(terminated(_), N, T) :-
    write(terminating(N)), nl,
    multi_reduce(T), !.
    
% multi_reduce([
%      job(1, [nrev([1,2,3,4,5,7,8], R), {write(job1(R)), nl}]),
%      job(2, [nrev([1,2,3,4,5], R1), {write(job2(R2)), nl}]),
%      job(3, [fact(10,Fact), {write(job3(Fact)), nl}])
%   ]).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  reducef 
%     functional style version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
reducef([]).

reducef([Var=Rhs|T]) :- !,
    reducef([Rhs, Var|T]).

reducef([return(Value), Var|T]) :- !,
    Var = Value,
    reducef(T).

reducef([{X}|T]) :-
    call(X), !,
    reducef(T).

reducef([write(X)|T]) :- !,
    write(X),
    reducef(T).

reducef([nl|T]) :-
    nl,
    reducef(T).
	    
reducef([Lhs|More]) :-
    eqnf(Lhs, Rhs), !,
    append(Rhs, More, More1),
    reducef(More1).

eqnf(factf(0), [return(1)]).
eqnf(factf(N), [
    {N1 is N-1},
    F1 = factf(N1),
    {Result is N*F1},
    return(Result)
    ]).

eqnf(nrev([H|T]), [
    T1 = nrev(T),
    Result = concat(T1, [H]),
    return(Result)
    ]).
eqnf(nrev([]), [return([])]).

eqnf(concat([H|T], T1), [
    T2 = concat(T, T1),
    return([H|T2])
    ]).
eqnf(concat([], X), [return(X)]).

% reducef([X=factf(4), write(X), nl]).
% reducef([X=nrev([a,b,c,d]), write(X), nl]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reducec 
%     completed version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
reducec([], _, _, []) :- !,
    write(stopped), nl.


% send(Id, Msg, Origin_Env, Updated_Env) 
%   - sends the message to process Id
send(Id, Msg, [job(Id, Goals, Message)|T], [job(Id, Goals, Message1)|T]) :-
    !,
    append(Message, [Msg], Message1).
send(Id, Msg, [H|T], [H|T1]) :-
    send(Id, Msg, T, T1).
