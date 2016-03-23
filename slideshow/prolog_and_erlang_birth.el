#lang slideshow

(require "utils/common.el")

(define (prolog code) (text code 'modern 32))

(define (prolog-small code) (text code 'modern 20))

(define (csharp code) (text code 'modern 32))

(define (todo msg) (colorize (t msg) "red"))

(define (cmd-input input) (colorize (text input (cons 'bold (current-main-font)) 32) "black"))

(define (cmd-output output) (colorize (text output (cons 'italic (current-main-font)) 32) "green"))

(define (s-line) (colorize (hline (* 3/4 client-w) gap-size) "green"))

;
; WIP

;
;


(title "Prolog and the birth of Erlang")

(slide
    #:gap-size (* (current-gap-size) 3)
    (text "A (very) short history of the birth of Erlang" (current-main-font) 42)
    'next
    (vr-append (para "The success of the development is in large measure due to Prolog (indeed had it not been for Prolog it is dobtful whether a language such as Erlang would have emerged).")
               (it "-- Joe Armstrong"))
)

(slide 
    #:title "Prolog intrduction"
    (table 2
        (list (t "Appeared in: ") (t "1972")
              (t "Designed by: ") (t "Alain Colmerauer")
              (t "Influenced: ") (t "Erlang, OZ ") 
	      (t "Paradigm:") (t "Logic programming"))
	(list* lc-superimpose cc-superimpose)
	cc-superimpose
	gap-size
	gap-size
    )
)

(slide 
    #:title "Erlang intrduction"
    (table 2
        (list (t "Appeared in: ") (t "1986")
              (t "Designed by: ") (t "Ericsson, Joe Armstrong")
              (t "Influenced by: ") (t "Prolog, SmallTalk ") 
	      (t "Paradigm:") (t "Concurrent, functional"))
	(list* lc-superimpose cc-superimpose)
	cc-superimpose
	gap-size
	gap-size
    )
)

(slide
    (hc-append (t "Let's start ") (bt "Pro") (t "gramming in ") (bt "Log") (t "ic"))
)

(slide
    #:title "Data type - 1"
    (ht-append (* gap-size 4)

    (vl-append (* gap-size 2)
        (vl-append (* gap-size 0.5)
            (bt "Atom")
	    (t " - x")
	    (t " - rainy")
	    (t " - 'this is a atom'")
	)
        (vl-append (* gap-size 0.5)
            (bt "Number")
	    (t " - Float")
	    (t " - Integer")
	)
        
    )
   
    (vl-append (* gap-size 2)
        (vl-append (* gap-size 0.5)
            (bt "Variable")
	    (t " - Tail")
	    (t " - Token")
	    (t " - Long_variable")
	)
        (vl-append (* gap-size 0.5)
            (bt "Compound term")
	    (t " - rainy(beijing)")
	    (t " - person(Name, 26)")
        )
    )

    )
)

(slide
    #:title "Data type - 2"
    (vl-append (* gap-size 3)
    (vl-append (* gap-size 1)
        (bt "List")
	(ht-append (t "  if [H|T] is [1,2,3,4], then ") (colorize (bt "H") "blue") (t " is 1, ") (colorize (bt "T") "blue") (t " is [2,3,4]"))
	(ht-append (t "  if [H|T] is [a], then ") (colorize (bt "H") "blue") (t " is a, ") (colorize (bt "T") "blue") (t " is []"))
    )
    (vl-append (* gap-size 1)
        (bt "String")
        (t "  \"Hello World\"")
    )
    )
)

(slide
    (para "Prolog programs describe relations, defined by means of clauses. Pure Prolog is restricted to Horn clauses. There are two types of clauses: " (bt "Facts") " and " (bt "Rules."))
    'next
    (colorize (hline (* 3/4 client-w) gap-size) "green")    
    (prolog "employ(thoughtworks, hankai).")
)

(slide
    #:title "Fact"
    (para "A fact is a predicate expression that makes a declarative statement about the problem domain.")
)

(slide
    #:title "Example of Facts"
    (vl-append (* gap-size 0.8)
        (t "                                         ")
        (prolog "employ(thoughtworks, hankai).")	
        (prolog "rainy(beijing).")
        (prolog "cold(beijing).")
	(prolog "love(wangfei, liyapeng).")
	(prolog "love(liyapeng, wangfei).")
        (prolog "member([H|T], H).")
    )
)

(slide
    #:title "Rule"
    (vl-append (* gap-size 2)
        (t "A rule is of form")
	(bt "    Head :- Body")
	(hc-append 
            (t "and is read as ") 
            (colorize (t "'Head is true if Body is true.'") "blue")
	)
    )
    'next
    (colorize (hline (* 3/4 client-w) gap-size) "green")
    (vl-append (* gap-size 1)
    (t "Facts are Rules which are always true.")
    (prolog "employ(thoughtworks, hankai) :- true.")
    )
)

(slide
    #:title "Examples of Rule"
    (vl-append (* gap-size 1.5)

        (prolog "member([H|T], E) :- member(T, E).")

        (vl-append (* gap-size 0.2)
            (prolog "freeze(Where) :- ")
            (prolog "        rainy(Where), cold(Where).")	
        )

        (vl-append (* gap-size 0.2)
	    (prolog "married(Man, Woman) :-")
	    (prolog "        love(Man, Woman), love(Woman, Man).")	
        )
    )
)

(slide (t "Recursion"))

(slide
    (vl-append (* gap-size 2)
        (prolog "fact(0, 1).")
        (vl-append (* gap-size 0.2)
            (prolog "fact(N, Result) :-")
            (prolog "    N1 is N - 1,")
            (prolog "    fact(N1, Result1),")
            (prolog "    Result is Result1 * N.")
        )
    )
)

(slide
    (vl-append (* gap-size 2)
        (vl-append (* gap-size 1)
            (cmd-input "> fact(5, Factorial).")
            (cmd-output "> Factorial = 120;")
            (cmd-output "> true.")
        )
        (vl-append (* gap-size 1)
            (cmd-input "> fact(N, 720).")
            (cmd-output "> N = 6;")
            (cmd-output "> true.")
        )
        (vl-append (* gap-size 1)
            (cmd-input "> fact(5, 121).")
            (cmd-output "> false.")
        )
    )

)

(slide
    #:title "Unification ..."
    (para " refers to the process of taking two atoms (one from the query and the other being a fact or the head of a rule) and determining if there is a substitution which makes them the same.")
)

(slide
    #:title "Example of Unifications"
    (hc-append
        (bt "Unify ")
	(prolog "person(Name, 26)")
	(bt " and ")
	(prolog "Category(james, Age)")
	(t ", then ")
    )
    (vl-append (* gap-size 1.2)
	(hc-append (bt "Category") (t " is ") (colorize (t " person") "blue"))
	(hc-append (bt "Name") (t " is ") (colorize (t " james") "blue"))
	(hc-append (bt "Age") (t " is ") (colorize (t " 26") "blue"))	
    )
)

(slide
    (t "Code as data")
)

(slide
    #:layout 'center
    (vl-append (* gap-size 4)
        (bt "Simple C# code")
        (vl-append (* gap-size 0.5)
            (csharp "if (user.IsValid())")
            (csharp "{")
            (csharp "    SendInvocation();")
            (csharp "    SaveUserData();")
            (csharp "}")	
        )
    )
)

(require slideshow/code)
(slide
    #:title "So, code as data - clause predicate"
    (vl-append (* gap-size 1)
        (cmd-input "> clause(fact(5, 120), Body).")
        (cmd-output "> Body = (N1 is 5 - 1, fact(N1, Result1), Result is Result1 * 5))")
    )

    'next
    (colorize (hline (* 3/4 client-w) gap-size) "green")
    (vl-append (* gap-size 2)
        (prolog "fact(0, 1).")
        (vl-append (* gap-size 0.2)
            (prolog "fact(N, Result) :-")
            (prolog "    N1 is N - 1,")
            (prolog "    fact(N1, Result1),")
            (prolog "    Result is Result1 * N.")
        )
    )
)

(slide
    #:title "the first interperter"
    (para "The first step is to program a suspendable computation, which implemented by a meta interpreter that can be suspended at any time, and could be resume the computation later.")
)

(slide
    #:title "Code"
    (vl-append (* gap-size 1.5) 
        (vl-append
            (prolog "reduce([])")
        )
        (vl-append (* gap-size 0.2)
            (prolog "reduce([{H}|T]) :-")
            (prolog "    call(H),")
            (prolog "    reduce(T).")	
        )
        (vl-append (* gap-size 0.2)
	    (prolog "reduce([H|T]) :-")
            (prolog "    eqn(H,Body),")
            (prolog "    append(Body, T, NewGoalList),")	
            (prolog "    reduce(NewGoalList).")
	)
    )
    
    'next
    (colorize (hline (* 3/4 client-w) gap-size) "green")
    (hc-append (bt "{H}: ") (t "'H' is a prolog built-in predicate."))
    (hc-append (t "Defined ") (bt "eqn(X)") (t " in next slide."))
)

(slide
    #:title "eqn"
    (vl-append (* gap-size 1.5)
        (prolog "eqn(fact(0,1), []).")
        (vl-append (* gap-size 0.2)
	    (prolog "eqn(fact(N,R),")
     	    (prolog "       [{N1 is N-1}, fact(N1,R1), {R is R1*N}]).")
        )
    )
)

(define (runtime-output output) (text output (cons 'bold (current-main-font)) 20))

(slide
   (runtime-output "reduce([fact(3,X1), {write(result(X1)), nl}]).")
   'next
   (runtime-output "reduce([{X3 is 3-1}, fact(X3,X2), {X1 is 3*X2}, {write(result(X1))}]).")
   'next 
   (runtime-output "reduce([fact(2,X2), {X1 is 3*X2}, {write(result(X1)), nl}]).")
   'next 
   (runtime-output "reduce([{X4 is 2-1}, fact(X4,X3), {X2 is 2*X3}, {X1 is 3*X2}, {write(result(X1))}]).")
   'next 
   (runtime-output "reduce([fact(1,X3), {X2 is 2*X3}, {X1 is 3*X2}, {write(result(X1)), nl}]).")
   'next 
   (runtime-output "reduce([{X5 is 1-1},fact(X5,X4), {X3 is 1*X4},{X2 is 2*X3}, {X1 is 3*X2}, {write(result(X1))}]).")
   'next 
   (runtime-output "reduce([fact(0,X4), {X3 is 1*X4}, {X2 is 2*X3}, {X1 is 3*X2}, {write(result(X1))}]).")
   'next 
   (runtime-output "reduce([{X3 is 1*1}, {X2 is 2*X3}, {X1 is 3*X2}, {write(result(X1))}]).")
   'next 
   (runtime-output "reduce([{X2 is 2*1}, {X1 is 3*X2}, {write(result(X1))}]).")
   'next 
   (runtime-output "reduce([{X1 is 3*2}, {write(result(X1))}]).")
   'next 
   (runtime-output "reduce([{write(result(6))}]).")
   'next 
   (runtime-output "reduce([]).")
)

(slide
    (para "The list of goals which remains to be reduced at any particular point in the computation is a normal Prolog data structure which can be mainipulated in any way required by user.")
)

(slide
    (t "Suspending the computation after a fixed number of reductions")
)

(slide
    #:title "Suspending the computation after 20 reductions"

    (vl-append (* gap-size 2)
        (prolog "reduce([], N, terminated(N)).")
        (prolog "reduce(Goals, 20, continuation(Goals)).")
    )
)

(slide
    #:title "Increase reduction for each step of computation"
    (vl-append (* gap-size 2)
        (vl-append (* gap-size 0.2)
            (prolog "reduce([{X}|T], Reductions, Result) :-")
            (prolog "    call(X),")
            (text "        Reductions1 is Reductions + 1," (cons 'bold (current-main-font)) 32)
            (prolog "    reduce(T, Reductions1, Result).")
        )

        (vl-append (* gap-size 0.2)
            (prolog "reduce([H|T], Reductions, Result) :-")
            (prolog "    eqn(H, Body),")
            (prolog "    append(Body, T, NewGoals),")
            (text "        Reductions1 is Reductions + 1," (cons 'bold (current-main-font)) 32)
            (prolog "    reduce(NewGoals, Reductions1, Result).")
	)
    )
)

(slide
    #:title "Input together"

    (vl-append (* gap-size 1.5)
        (prolog "reduce([], N, terminated(N)).")

        (prolog "reduce(Goals, 20, continuation(Goals)).")

        (vl-append (* gap-size 0.2)
            (prolog "reduce([{X}|T], Reductions, Result) :-")
            (prolog "    call(X),")
            (prolog "    Reductions1 is Reductions + 1,")
            (prolog "    reduce(T, Reductions1, Result).")
        )

        (vl-append (* gap-size 0.2)
            (prolog "reduce([H|T], Reductions, Result) :-")
            (prolog "    eqn(H, Body),")
            (prolog "    append(Body, T, NewGoals),")
            (prolog "    Reductions1 is Reductions + 1,")
            (prolog "    reduce(NewGoals, Reductions1, Result).")
	)
    )
)

(slide
    #:title "Multi task scheduler"
    (para "The scheduler takes a list of tasks of the form job(N,Goals), and allows each job to run for at most 20 reductions, it then goes on to the next task, until no more tasks remain.")

    'next
    (colorize (hline (* 3/4 client-w) gap-size) "green")
    (hc-append (bt "N") (t " is the name of the task."))
    (hc-append (bt "Goals") (t " is the goal list representing the task."))
)

(slide
    #:title "Code"
    (vl-append (* gap-size 1.5)
        (vl-append (* gap-size 0.4)
            (prolog "multi_reduce([]).")
            (prolog "multi_reduce([job(N,Goals)|T]) :-")
            (prolog "    reduce(Goals, 0, Result),")
            (prolog "    multi_reduce(Result, N, T).")
        )
        (vl-append  (* gap-size 0.4)      
            (prolog "multi_reduce(terminated(Reds), N, T) :-")
            (prolog "    write(terminating(N)), nl,")
            (prolog "    multi_reduce(T).")
	)
        (vl-append (* gap-size 0.4)
            (prolog "multi_reduce(continuation(Goals), N, T) :-")
            (prolog "    write(suspending(N)), nl,")
            (prolog "    append(T, [job(N, Goals)], NewJobs),")
            (prolog "    multi_reduce(NewJobs).")
	)
    )
)

(slide
    (t "Functional style programming")
)



(slide
    #:title "Intrudce '=' expression and 'return'"
    (vl-append (* gap-size 1)
        (vl-append (* gap-size 0.2)
            ; A long whitspace for adjusting layout :(
            (prolog "reduce([]).                               ") 
            (prolog "reduce([Val = Exp|T]) :-")
            (prolog "    reduce([Exp, Val|T]).")
        )
        (vl-append (* gap-size 0.4)
            (prolog "reduce([return(Value), Val|T]) :-")
            (prolog "    Val = Value,")
            (prolog "    reduce(T).")
        )
    )
   
    (s-line)

    (vl-append (* gap-size 0.5)
        (prolog "[Val = Exp|T]")
        (t " -> [Exp, Val|T]")
    )
    'next
    (vl-append (* gap-size 0.5)
        (prolog "return(Value)")
        (t " -> Val = Value")
    )
)

(slide
    #:title "functional style of eqn"
    (vl-append (* gap-size 2)
        (vl-append (* gap-size 0.2)
            ; A long whitspace for adjusting layout :(
            (prolog "eqn(fact(0), [                            ") 
            (prolog "    return(1)")
            (prolog "]).")
        )
        (vl-append (* gap-size 0.2)
            (prolog "eqn(fact(N), [")
            (prolog "    {N1 is N - 1},")
            (prolog "    R1 = fact(N1),")
            (prolog "    {Result is N * R1},")
            (prolog "    return(Result)")
            (prolog "]).")
        )
    )
    'next
    (s-line)
    (hc-append (t "As a function, eqn returns a value via ") (bt "return(Result)"))
)

(slide
    #:title "Functianl style - input together"
    (vl-append (* gap-size 0.8)
        (vl-append (* gap-size 0.1)
            ; A long whitspace for adjusting layout :(
            (prolog-small "reduce([]).                                                       ") 
            (prolog-small "reduce([Val = Exp|T]) :-")
            (prolog-small "    reduce([Exp, Val|T]).")
        )
        (vl-append (* gap-size 0.1)
            (prolog-small "reduce([return(Value), Val|T]) :-")
            (prolog-small "    Val = Value,")
            (prolog-small "    reduce(T).")
        )
        (vl-append (* gap-size 0.1)
            (prolog-small "reduce([{X}|T]) :-")
            (prolog-small "    call(X),")
            (prolog-small "    reduce(T).")
        )
        (vl-append (* gap-size 0.1)
            (prolog-small "reduce([H|T]) :-")
            (prolog-small "    eqn(H, Body),")
            (prolog-small "    append(Body, T, NewList),")
            (prolog-small "    reduce(NewList).")
        )
        (vl-append (* gap-size 0.1)
            ; A long whitspace for adjusting layout :(
            (prolog-small "eqn(fact(0), [                            ") 
            (prolog-small "    return(1)")
            (prolog-small "]).")
        )
        (vl-append (* gap-size 0.1)
            (prolog-small "eqn(fact(N), [")
            (prolog-small "    {N1 is N - 1},")
            (prolog-small "    R1 = fact(N1),")
            (prolog-small "    {Result is N * R1},")
            (prolog-small "    return(Result)")
            (prolog-small "]).")
        )
    )
)

(slide
     (vc-append (* gap-size 3)
         (colorize (bt "LAST station") "red")
	 (t "Support process creation and simple message passing")
     )
)

(slide
    (vc-append (* gap-size 1)
        (t "Each process is represented by a data structure of the form")
	(bt "job(Id, Goals, MailBox)")
    )
    'next
    (s-line)
    (para "Id is the name of the process Goals is a list of unsolved goals representing the computation and MailBox is a list of messages which have been sent to but not yet received by the process.")
)

(slide
    (t "Updated reduce:")
    (bt "reduce(Goals, Id, MailBox, Env)")

    'next
    (s-line)
    (para "The reduce represents the current state of a simple multitasking operating system. Goals, Id and mailBox represents the currently executing process and Env a list of all suspended processes")
)



(slide
    #:title "primitive: spawn - new process creation"
    (vl-append (* gap-size 0.2)
        (prolog "reduce([spawn(Id, Goals)|T],MyId,MyMsgs,Env) :-")
        (prolog "    write(spawning(Id)).")
        (prolog "    append(Env, [job(Id, Goals, [])], Env1),")
        (prolog "    reduce(T, MyId, MyMsgs, Env1).")	
    )
)

(slide
    #:title "primitive: send"
    (vl-append (* gap-size 0.2)
        (prolog "reduce([send(Id, Msg)T], MyId, MyMsgs, Env0) :-")
	(prolog "    send(Id, Msg, Env0, Env1),")
	(prolog "    reduce(T, MyId, MyMsgs, Env1).")
    )

    'next
    (s-line)

    (vl-append (* gap-size 2)
        (vl-append (* gap-size 0.2)
            (prolog "send(Id, Msg, [job(Id, Goals, Messages)|T],")
	    (prolog "           [job(Id, Goals, Messages1)|T]) :-")
	    (prolog "    append(Messages, [Msg], Messages1).")
	)
        (vl-append (* gap-size 0.2)
            (prolog "send(Id, Msg, [H|T], [H|T1]) :-")
	    (prolog "    send(Id, Msg, T, T1).")
	)
    )
)

(slide
    #:title "primitive: receive"
    (vl-append (* gap-size 2)
        (vl-append (* gap-size 0.2)
            (prolog "reduce([receive|T], MyId, [Message|More], Env) :-")
	    (prolog "    reduce([return(Message)|T], MyId, More, Env).")
        ) 
        (vl-append (* gap-size 0.2)
            (prolog "reduce([receive|T], MyId, [], Env) :-")
	    (prolog "    write(suspending(MyId)),")
	    (prolog "    append(Env, [job(MyId, [receive|T], [])], Env1),")
	    (prolog "    reduce([], none, [], Env1).")
        ) 
    )
)

(slide
    #:title "New meta language"
    (ht-append (* gap-size 3)
    
      (vl-append (* gap-size 1.5)
        (vl-append (* gap-size 0.2)
            (prolog-small "eqn2(go, [")
	    (prolog-small "     spawn(sender, [sender(5)]),")
	    (prolog-small "     spawn(catcher, [catch])")
	    (prolog-small "]).")
	)
        (vl-append (* gap-size 0.2)
            (prolog-small "eqn2(sender(0), [")
	    (prolog-small "     send(catcher, stop)")
	    (prolog-small "]).")
	)
        (vl-append (* gap-size 0.2)
            (prolog-small "eqn2(sender(N), [")
	    (prolog-small "     {write(sending(pip(N))), nl},")
	    (prolog-small "     send(catcher, pip(N)),")
	    (prolog-small "     {N1 is N - 1},")
	    (prolog-small "]).")
	)
      )

      (vl-append (* gap-size 1.5)
        (vl-append (* gap-size 0.2)
            (prolog-small "eqn2(catch, [")
	    (prolog-small "     X = receive,")
	    (prolog-small "     {write(received(X)), nl},")
	    (prolog-small "     catch(X)")
	    (prolog-small "]).")
	)
        (vl-append (* gap-size 0.2)
            (prolog-small "eqn2(catch, [")
	    (prolog-small "     X = receive,")
	    (prolog-small "     {write(received(X)), nl},")
	    (prolog-small "     catch(X)")
            (prolog-small "]).")
        )
        (vl-append (* gap-size 0.2)
            (prolog-small "eqn2(catch(stop),")
	    (prolog-small "[]).")
	    (prolog-small "eqn2(catch(_), [")
	    (prolog-small "catch")
	    (prolog-small "]).")
	)
      )
    )
    
)

(slide
    (vc-append (* gap-size 2)
        (vc-append (* gap-size 0.5)
            (t "Joe Armstrong's paper")
    	    (bt "www.erlang.se/publications/prac_appl_prolog.ps")
        ) 
        (vc-append (* gap-size 0.5)
            (t "Source code in the slides")
            (bt "https://github.com/isaachan/erlang_interpreter.git")
        )
    )
)
