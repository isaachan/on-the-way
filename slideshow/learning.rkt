#lang slideshow

(require slideshow/start)
(require slideshow/pict)
(require slideshow/balloon)

(enable-click-advance! #t)

(start-at-recent-slide)
(set-use-background-frame! #f)

(define hw (t "Hello World!"))

(slide #:inset (make-slide-inset 5 5 5 5) hw)

(re-slide (most-recent-slide))

(re-slide (most-recent-slide) (t "attchment 1"))

(re-slide (most-recent-slide) (t "attchment 1"))

(re-slide (most-recent-slide) (colorize (t "attchement 2") "red"))

(slide
    (cloud 30 30)
    (cloud 30 30 "gray")

    (file-icon 30 30 "red")
    (file-icon 30 30 "red" #t)
  
    (desktop-machine 0.5)
;    (desktop-machine 0.5 ('plt))
;    (desktop-machine 0.5)    
)

(define whoru (t "Who are you?"))
(define name (t "This is xxx."))
(define screen
    (frame
        #:color "green"
        (inset 
            (ht-append 
                whoru
	        (inset name (* 5 gap-size) (* 5 gap-size) 0 0)
            )
            5
        )
    )
)
(slide screen)
(slide
    (let-values ([(fdx fdy) (rc-find screen whoru)]
                 [(adx ady) (lt-find screen name)])
        (pin-over
  	    screen
	    fdx fdy
	    (pip-arrow-line (- adx fdx) (- ady fdy) gap-size)
	)    
    )
)

(slide 
    (frame (t "Hello World!"))
    (frame (inset (t "Hello World!") 10))
    (frame (inset (t "Hello World!") 10 10 10 10))
    (frame (inset (t "Hello World!") 10 20))

)

(slide 
   (t "Hello world!")
   (scale (t "Hello world!") 2)
   (scale (t "Hello world!") 2 2)
   (scale (t "Hello world!") 4 2)
   (scale (t "Hello world!") 2 4)
   (scale/improve-new-text (t "Hello world!") 2)
)


(slide 
     (clip (pin-over 
        (t "Hello World!")
        10 10
	(t "Pin-over")
      )
    )

(hline 100 1)

(inset/clip
(pin-over 
      (t "Hello World!")
        10 10
	(t "Pin-over")
    )
10
)

(pin-over 
      (t "Hello World!")
        10 10
	(t "Pin-over")
    )
)

(slide #:title "Pict combiners"
    (t "Hello World!")
    (scale (frame (t "Hello World!")) 2)
    (ghost (scale (frame (t "Hello World!")) 2 2))
    (frame (ghost (scale (frame (t "Hello World!")) 2 2)))
    (scale (frame (t "Hello World!")) 4 2)
    (scale (frame (t "Hello World!")) 2 4)    
)

