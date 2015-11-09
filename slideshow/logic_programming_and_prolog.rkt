#lang slideshow

(require "utils/common.rkt")

(define (value x) x)

(title "Logic programming and Prolog")

(topic "Introduction to logic")

(left-right-panel
    (vc-append (* gap-size 1.5)
        (s "Syllogism (三段论)" 36)
        (vl-append (* gap-size 1.2)
            (t "All humans are mortal.")
            (t "All Greeks are humans.")
            (t "All Greeks are mortal.")
	)
    ) 

    (scale (bitmap "./images/Aristotle.jpg") 0.4)
    cc-superimpose
    rb-superimpose
)

(define sperator (colorize (hline 400 1) "blue"))

(topic "From classic to new logic" "proposition, relation, class, etc.")

(topic "Propositional calculus(命题演算)")

(let 
  ([prop (lambda content (s (car content) 38))])
  (on-lt (vl-append (* gap-size 1)
    (prop "Beijing is rainy.")
    (prop "Shanghai is rainy.")
    (prop "Beijing is cold.")
    sperator

    (prop "Shanghai is not cold.")
    sperator

    (prop "Beijing and Shanghai are rainy.")
    sperator

    (prop "If Beijing is rainy, and Beijing is cold, then Beijing is freeze.")
    sperator

    (prop "Jane is Helen's daughter.")
    (prop "Jane is Peter's daugther.")
  ))
)

(slide
  (vc-append (* gap-size 1.5)
   (s "NOT ¬" 50)
   (s "AND ∧" 50)
   (s "OR ∨" 50)
   (s "IMPLY →" 50)
  )
  (comment "回到逻辑做为日常用语的例子")
)

(topic "First-order logic" "predicate, function, variable, quantification, etc.")

(let 
  ([prop (lambda content (s (car content) 38))])
  (on-lt (vl-append (* gap-size 1)
    (prop "Rainy(Where)")
    (prop "Cold(Where)")
    sperator
    (prop "Rainy(Where) ∧ Cold(Where) → Freeze(Where)")
    sperator
    (prop "Daughter(jane, helen)")
    (prop "Daughter(jane, peter)")
  ))
)

(topic "Horn Clause" "A subset of first-order logic.")

(let
  (
    [prolog (vc-append (* gap-size 3) (s "Prolog" 110) (hc-append (bt "PRO") (t "GRAMMING in ") (bt "LOG") (t "IC")))]
    [feature-list
      (vc-append (* gap-size 1) 
        (t "Logic programming paradigm")
        (t "Appeared in 1972")
	(t "Influenced by Erlang, Oz")
        (t "Expert system")
        (t "Artificial Intelligence, AI")
	(t "Natural language processing, NLP")
        (t "Werid syntax")
	sperator
	(t "Unification")
	(t "Backtracking")
	(t "No variables")
	(t "Recusive")
	(t "Pattern matching")
        (t "Meta-interpreters and reflection")
      )
    ] 
    [fixed-feature-list
      (vc-append (* gap-size 1) 
        (t "Logic programming paradigm")
        (t "Appeared in 1972")
	(colorize (bt "Influenced by Erlang, Oz") "red")
        (t "Expert system")
        (t "Artificial Intelligence, AI")
	(t "Natural language processing, NLP")
        (t "Werid syntax")
	sperator
	(t "Unification")
	(t "Backtracking")
	(t "No variables")
	(t "Recusive")
	(t "Pattern matching")
        (t "Meta-interpreters and reflection")
      )
    ]
  )
  
  (left-right-panel (blank) prolog)
  (left-right-panel feature-list prolog)
  (left-right-panel fixed-feature-list prolog)
)

(left-right-panel
  (s "Fact" 110)
  (vl-append (* gap-size 1)
    (t "rainy(beijing).")
    (t "rainy(shanghai).")
    (t "cold(beijng).")
    (t "male(peter).")
    (t "female(helen).")
    sperator
    (t "daughter(jane, helen).")
    (t "daughter(jane, peter).")
  )
  cc-superimpose
  lc-superimpose
)

(top-bottom-panel
  (s "Rule" 110)
  (vl-append (* gap-size 1)
    (t "freeze(Where) :- rainy(Where), cold(Where).")
    (t "mother(M, D) :- son(D, M), female(M).")
    (t "mother(M, D) :- daughter(D, M), female(M).")
  )
  cb-superimpose
  lc-superimpose
)

(left-right-panel
  (s "Goal" 110)
  (vl-append gap-size
    (vl-append
      (t "?- rainy(beijing).")
      (t "yes.")
      (t "?- rainy(chengdu).")
      (t "no."))
    sperator
    (vl-append
      (t "?- rainy(Where).")
      (t "beijing;")
      (t "shanghai;")
      (t "no."))
    sperator
    (vl-append
      (t "?- frezze(Where).")
      (t "beijing;")
      (t "no."))
    sperator
    (vl-append
      (t "?- mother(jane, Mother)")
      (t "helen;")
      (t "no."))
  )
)

(define code-block 
  (lambda (converter . lines)
　  (apply vl-append (do-code-block converter lines '()))
  )
)

(define do-code-block (lambda (converter lines picts)
  (if (= 0 (length lines))
      picts
      (do-code-block converter
                      (cdr lines)
                      (append picts (list (converter (car lines))))
      )
  )))

(define member-sig (text "member(Element, List)" (cons 'bold '()) 70))

(top-bottom-panel
  member-sig
  (blank)
)

(top-bottom-panel
  member-sig
  (vl-append 10
   (inset (code-block (lambda (line) (colorize (text line 'modern 20) "blue"))
      "public boolean member(element, list) {"
      "  for (int i = 0; i < list.length(); i++) {"
      "    if (list.get(i).equals(element))"
      "      return true;"
      "  }"
      "  return false;"
      "}"
    ) 5 5 5 5)
    (inset (code-block (lambda (line) (text line 'modern 20))
      "(define member (lambda (element list)"
      "  (cond"
      "    ((= 0 (length list)) #false)"
      "    ((= (car list) element) #true)"
      "    (else (member element (cdr list)))"
      ")))"
    ) 5 5 5 5)
  )
  cc-superimpose
  ct-superimpose
)

(slide
  (vl-append gap-size
    (text "member(H, [H|T])." '(bold . modern) 30)
    (text "member(E, [H|T]) :- member(E, T)." '(bold . modern)  30)
  )
)

(define (how-member-execute l1 l2 l3 l4 l5 l6 l7 l8 l9)
(slide #:title "How member(3, [1,2,3,4]) executes?"
(vl-append gap-size
  (l1 (t "member(3, [1,2,3,4]) doesn't match member(H, [H|T])."))
  (l2 (hc-append (t "     then goes to match member(3, [1|[2,3,4]]). ") (colorize (t "G001") "red")))
  (l3 (hc-append (t "     then goes to match member(3, [2,3,4]). ") (colorize (t "G002") "red")))
  (l4 (t "           member(3, [2,3,4]) doesn't match member(H, [H|T])."))
  (l5 (hc-append (t "                 then goes to match member(3, [2|[3,4]]). ") (colorize (t "G003") "red")))
  (l6 (hc-append (t "                 then goes to match member(3, [3,4]). ") (colorize (t "G004") "red")))
  (l7 (hc-append (t "                 member(3, [3,4]) matches member(H, [H|T]).") (colorize (t "TRUE") "green")))
  (l8 (hc-append sperator sperator))
  (l9 (colorize (bt "G001 = G002 = G003 = G004 = TRUE") "green"))
)
)
)

(how-member-execute ghost ghost ghost ghost ghost ghost ghost ghost ghost)
(how-member-execute value ghost ghost ghost ghost ghost ghost ghost ghost)
(how-member-execute value value ghost ghost ghost ghost ghost ghost ghost)
(how-member-execute value value value ghost ghost ghost ghost ghost ghost)
(how-member-execute value value value value ghost ghost ghost ghost ghost)
(how-member-execute value value value value value ghost ghost ghost ghost)
(how-member-execute value value value value value value ghost ghost ghost)
(how-member-execute value value value value value value value ghost ghost)
(how-member-execute value value value value value value value value ghost)
(how-member-execute value value value value value value value value value)


(define merchant_guide_desc 
   (para "The symbols 'I', 'X', 'C', and 'M' can be repeated three times in succession, but no more. (They may appear four times if the third and fourth are separated by a smaller value, such as XXXIX.) 'D', 'L', and 'V' can never be repeated."))

(topic "Merchant's guide to the galaxy")

(top-bottom-panel
  merchant_guide_desc
  (blank)
)

(top-bottom-panel
  merchant_guide_desc
  (code-block (lambda (line) (text line 'modern 25))
    "repeat([])."
    "repeat([_])."
    "repeat([_,_])."
    "repeat([H,H,H|R]) :-"
    "    member(H, [i,x,c,m]), not(member(H, R)), repeat(R)."
    "repeat([H,H,H,H|_]) :- fail."
    "repeat([H,H,H,Other,H|R]) :-"
    "    member(H, [i,x,c,m]), not(member(H,R)),"
    "    greaterThan(H,Other), repeat(R)."
  )
)

(slide #:title "Towers of Hanoi puzzle"
  (bitmap "images/towers_of_hanoi_puzzle.gif")
)

(left-right-panel
  (code-block (lambda (line) (text line 'modern 25))
    "move(1,X,Y,_) :-"  
    "    write('Move top disk from '),"
    "    write(X),"
    "    write(' to '), "
    "    write(Y), nl."
    ""
    "move(N,X,Y,Z) :- "
    "    N>1," 
    "    M is N-1, "
    "    move(M,X,Z,Y), "
    "    move(1,X,Y,_), "
    "    move(M,Z,Y,X). "
  )
  (code-block (lambda (line) (s line 25))
    "?- move(1, left, middle, right)."
    "Move top disk from left to middle"
    "true."
    ""
    "?- move(3, left, middle, right)."
    "Move top disk from left to right"
    "Move top disk from left to middle"
    "Move top disk from right to middle"
    "Move top disk from left to right"
    "Move top disk from middle to left"
    "Move top disk from middle to right"
    "Move top disk from left to right"
    "true ."
  )
)

(topic "A very first version of Erlang")

(define reduce-panel
  (lambda (left right) 
    (slide
      (ht-append 
        (cc-superimpose (blank (* client-w 0.25) client-h) left) 
        (cc-superimpose (blank (* client-w 0.75) client-h) right)
      )
    )
  )
)

(let
  ([reduce (code-block (lambda (line) (text line 'modern 23))
    "reduce([])."
    ""
    "reduce([{X}|T]) :-"
    "  call(X),"
    "  reduce(T)."
    ""
    "reduce([X|T]) :-"
    "  eqn(X, Steps),"
    "  append(Steps, T, T1),"
    "  reduce(T1)."
    ""
    "eqn(fact(0,1), [])."
    ""
    "eqn(fact(N,F)," 
    "  [{N1 is N-1}, "
    "   fact(N1,F1), "
    "   {F is F1 * N}])."
  )]
  [reduce-run (code-block (lambda (line) (s line 23))
    "reduce([fact(3, F)])."
    "reduce([{N1 is 3-1}, fact(N1, F1), {F is F1*3}])."
    ""
    "reduce([fact(2, F1), {F is F1*3}])."
    "reduce([{N2 is 2-1}, fact(N2, F2), {F2 is F1*2}, {F is F1*3})."
    ""
    "reduce([fact(1, F2), {F2 is F1*2}, {F is F1*3}])."
    "reduce([{N3 is 1-1}, fact(N3, F3), {F3 is F2*1}, {F2 is F1*2}, {F is F1*3}])."
    ""
    "reduce([fact(0,F3), {F2 is F3*1}, {F1 is F2*2}, {F is F1*3}])."
    "reduce([fact(0,1), {F2 is 1*1}, {F1 is F2*2}, {F is F1*3}])."
    ""
    "reduce([{F2 is 1*1}, {F1 is F2*2}, {F is F1*3}])."
    "reduce([{F1 is 1*2}, {F is F1*3}])."
    "reduce([{F is 2*3}])."
    "reduce([])."
  )]
  )

  (reduce-panel reduce (blank))
  (reduce-panel reduce reduce-run)
)

(topic "Natural language processing" "DCG - Definite Clause Grammar")

((lambda (left right bottom)
    (slide
      (vc-append
        (ht-append 
          (cc-superimpose (blank (/ client-w 2) (* client-h 0.6)) left) 
          (cc-superimpose (blank (/ client-w 2) (* client-h 0.6)) right)
        )
        sperator
        (cc-superimpose (blank client-w (* client-h 0.4)) bottom)
      )
    )
  )
  (vl-append (* gap-size 1.5)
    (t "a cat eats the fish.")
    (t "the cat eats a fish.")
    (t "a fish eats the cat.")
    (t "the fish eats a cat.")
    (t "......")
  )
  (code-block (lambda (line) (text line 'modern 25))
    "sentence --> "
    "  noun_phrase, verb_pharse."
    ""
    "noun_pharse --> det, noun."
    "verb_pharse --> verb, noun_pharse.  "
    ""
    "det --> [the]."
    "det --> [a]."
    "noun --> [cat]."
    "noun --> [fish]."
    "verb --> [eats]."
  )
  (vl-append
    (t "?- sentence([the, cat, eats, a, fish], []).")
    (t "yes.")
    (blank)
    (t "?- sentence([cat, the, eats, a, fish], []).")
    (t "no.")
    (blank)
    (t "?- sentence(X, []).")
    (colorize (t "Get all valid sentences.") "red")
  )
)

;(start-at-recent-slide)
; Flexiable
; Implementations
; Problem scope
