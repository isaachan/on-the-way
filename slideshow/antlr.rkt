#lang slideshow

(require "utils/common.rkt")

(title
    (vc-append 
         (text "How to" (current-main-font) 50)
	 (text " write your own language in 10 mins" (current-main-font) 50)
    )
)

(slide
    (hc-append 
        (bt "Language")
	(t " is a tree")
    )
)

(slide
    (vl-append (* gap-size 1)
        (t "                                            ")
        (t "Paragraph")
	(t "Sentence")
	(t "Phrase")
	(t "Word")
	(t "Letter")
    )
)

(slide
    (vl-append (* gap-size 1)
        (t "                                            ")    
        (t "namespace")
	(t "class")
	(t "method")
	(t "statement")
	(t "expression")
	(t "identifier")
	(t "keyword")
    )
)

(slide
    (hc-append (bt "Regconize") (t " a language"))
    'next
    (hc-append (t "Language") (bt " regconition"))
)

(slide
    (hc-append (bt "R") (t "ecursise ") (bt "D") (t "escent ") (bt "P") (t "arser"))
)

(slide
    (para "\"In computer science, a recursive descent parser is a kind of top-down parser built from a set of mutually recursive procedures (or a non-recursive equivalent) where each such procedure usually implements one of the production rules of the grammar. Thus the structure of the resulting program closely mirrors that of the grammar it recognizes.\"")
)

(define (csharp code)
    (text code 'modern 24)
)

(slide
    (vl-append (* gap-size 0.5)
        (csharp "// tokens = 'if', '(', 'Name', '==', '\"Kayla\"', ')'")
        (csharp "void Match_If_Statement(List<Token> tokens)")
	(csharp "{")
        (csharp "    Match_If_Keywork(tokens.Next());")
	(csharp "    Match_LeftBrace(tokens.Next();)")
	(csharp "    Match_Expression(tokens);")
	(csharp "    Match_RightBrace(tokens.Next())")
	(csharp "    // etc.")
	(csharp "}")
    )
)

(slide
    (item "After/while regconition")
    'next
        (subitem "translate to another language")
	(subitem "generate AST")
	(subitem "generate machine code")
	(subitem "gernate bytecode")
)

(slide
    (t "Descirpe the parse rules")
    'next
    (bt "Grammar")
    (t "")
    (t "")
    (it "a formal language specification")
 
)

(slide
    (t "LL(1), LL(*), LR(*), LL(k)")
)

(slide
    (hc-append (t "from ") (bt "grammar") (t " to ") (bt "parser"))
    'next
    (hc-append (t "shoud be ") (bt "automated!"))
)

(slide
    (t "lex")
    (t "yacc")
    'next
    (bt "ANTLR")
)

(slide
    (vr-append (* gap-size 3)
        (hc-append
            (bt "AN")
	    (t "other ")
            (bt "T")
	    (t "ool for ")
  	    (bt "L")
	    (t "anguage ")
	    (bt "R")
	    (t "egnition")
        )
        (vr-append (* gap-size 1)
            (hc-append 
	        (text "Terence Parr, " (current-main-font) 20)
	        (text "Since 1989" (current-main-font) 20)
            )
            (text "http://antlr.org " (current-main-font) 20)
        )
    )
)

(slide
    #:title "Where can you find antlr?"
    
    (vl-append (* gap-size 2)
        (hc-append (bt "Twitter") (t " search quering"))
	(hc-append (bt "Hive and Pig") (t " - data analysis system for Hadoop"))
	(hc-append (bt "Oracle") (t " SQL Developer"))
	(hc-append (bt "Hibernate") (t " HQL"))
	(hc-append (bt "NetBeans") (t " C++ parser"))
    )
)

(slide
   #:title "Why they choose ANTLR?"
   (t "grammar is easy to learn and use")
   'next
   (t "unified Lexer and Parser")
   'next
   (t "LL(k)")
   'next
   (t "tree grammar")
   'next
   (t "semantic and syntactic predicates")
   'next
   (t "error reporting and recovery")
   'next
   (t "grammars for exiting languages")
)

(slide
    (t "Demo")
)

(slide
    #:title "polish notation"
    (vl-append (* gap-size 3)
        (vl-append (* gap-size 1)
            (t "(+ 3 2)")
	    (t ">5")
        )
        (vl-append (* gap-size 1)
            (t "(* (+ 3 2) (- 5 3))")
	    (t ">10")
        )
    )
)
