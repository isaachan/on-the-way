;
; TODO
; Unify title and c-title
;

#lang slideshow

(provide title)
(provide s)
(provide topic)
(provide on-lt)
(provide left-right-panel)
(provide top-bottom-panel)
(provide tbp)

(define (adapt content)
    (if (= 1 (length content))
	         (if (string? (car content))
		   (s (car content) 64)
		   (car content)
		 )
                 (apply vc-append content)
	       )
)

(define title
  (lambda content
    (slide (vr-append (* gap-size 5)
             (vc-append 
               (* gap-size 3)
               (adapt content)            
             )
             (vr-append (* gap-size 0.5)
                (text "Han Kai" (cons 'bold (current-main-font)) 32)
                (text "http://isaachan.github.com" (current-main-font) 24)
		(hc-append 
                  (text "Thought" (cons 'bold (current-main-font)) 24)
                  (text "Works" (current-main-font) 24)
                )
                (text "@isaachan" (cons 'bold (current-main-font)) 32)
             )
	   )
    )
  )
)


(define (s content size) (text content (current-main-font) size))

;
; One-Topic-One-Slide pattern.
;
(define topic
  (lambda contents
    (cond
      ((= 1 (length contents)) (slide (s (car contents) 70)))
      ((= 2 (length contents))
           (slide 
             (vl-append (* gap-size 1.5)
               (s (car contents) 70)
               (s (car (cdr contents)) 30)
             )
           )
      )
    )
  )
)

; Helper function
(define (adpot-picts content) 
  (if (list? content)
    (apply vc-append content)
    (car content)
  )
)

;
; Locate content on left top corner.
;
(define on-lt 
  (lambda content
    (slide (lt-superimpose (blank client-w client-h) (adpot-picts content)))
  )
)

;
; Split panel into left and right
;
(define left-right-panel
  (lambda (left right [left-superimpose cc-superimpose] [right-superimpose cc-superimpose])
    (slide
      (ht-append 
        (left-superimpose (blank (/ client-w 2) client-h) left) 
        (right-superimpose (blank (/ client-w 2) client-h) right)
      )
    )
  )
)

;
; Split panel into top and bottom
;
(define top-bottom-panel
  (lambda (top bottom [top-superimpose cc-superimpose] [bottom-superimpose cc-superimpose])
    (slide
      (tbp top bottom top-superimpose bottom-superimpose)
    )
  )
)

(define tbp
  (lambda (top bottom [top-superimpose cc-superimpose] [bottom-superimpose cc-superimpose])
    (vc-append
      (top-superimpose (blank client-w (/ client-h 2)) top)
      (bottom-superimpose (blank client-w (/ client-h 2)) bottom)
    )
  )
)