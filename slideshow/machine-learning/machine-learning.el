#lang slideshow

(require "../utils/common.el")

(title "Machine Learning 101")

(topic "Question: Love or Action?" "what kind of movies are they?")

(topic "Learn from (historical) data")

(slide
    #:title "Data set"
    (table 4
	(list (t "Title")                      (t "#action scenarios") (t "#kiss scenarios") (t "Type")
	      (t "California Man")             (t "3")                 (t "104")             (t "love")
	      (t "He's Not Really into Dudes") (t "2")                 (t "100")             (t "love")
	      (t "Beautiful Woman")            (t "1")                 (t "81")              (t "love")
	      (t "Kevin Longblade")            (t "101")               (t "10")              (t "action")
	      (t "Robo Slayer 3000")           (t "99")                (t "5")               (t "action")
	      (t "Amped II")                   (t "98")                (t "2")               (t "action")
	      (t "???")                        (t "18")                (t "90")              (t "???"))
        (list* lc-superimpose cc-superimpose)
	cc-superimpose
	gap-size
	gap-size
    )
)

(slide
    #:title "Scatter Diagram"
    (bitmap "images/movie-scatter.png")    
)

(topic "DISTANCEs" "between unknown point to known points")

(top-bottom-panel
  (s "k-NN" 110)
  (para "The input consists of the k closest training examples in the feature space. The output depends on whether k-NN is used for classification or regression")
  cb-superimpose
  cc-superimpose
)

(topic "Handwriting Recognition")

(left-right-panel (scale (bitmap "images/desiontree.png") 0.8 0.8)
                  (s "Decision Tree" 64))

(left-right-panel (scale (bitmap "images/shannon.jpg") 1.5 1.5)
                  (s "Inofrmation gain (Entropy)" 32))


