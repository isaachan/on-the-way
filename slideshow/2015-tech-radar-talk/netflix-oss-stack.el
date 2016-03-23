
#lang slideshow

(require "../utils/common.el")

(title "Netflix OSS Stack")

(topic "Lisp")

(topic "Your first movie")

(slide
  (vc-append (* gap-size 2)
    (s "TECHNIQUE" 64)
    (s "DRIVEN NEW BUSINESS" 64)
    (s "AND BETTER LIFE" 64)
  )
)

(topic "Globally Distributed Video Streaming")

(slide 
  (scale (bitmap "images/house-of-cards.jpg") 0.25)
)

(slide
  (scale (bitmap "images/netflix-news-on-infoq.jpg") 0.45)
)

(left-right-panel
  (vc-append (* gap-size 3)
    (s "49" 120)
    (s "2666" 120)
  )
  (vc-append (* gap-size 3)
    (colorize (s "100+" 120) "red")
    (colorize (s "2,000,000,000" 70) "red")
  )
)

(define three-column-panel
  (lambda (c1 c2 c3 [c1-superimpose ct-superimpose] [c2-superimpose ct-superimpose] [c3-superimpose ct-superimpose])
    (slide
      (ht-append 
        (c1-superimpose (blank (/ client-w 3) client-h) c1) 
        (c2-superimpose (blank (/ client-w 3) client-h) c2)
        (c3-superimpose (blank (/ client-w 3) client-h) c3)
      )
    )
  )
)

(define (category c)
  (text c (cons 'bold (current-main-font)) 24)
)

(define (name text)
  (s text 24)
)

(three-column-panel
  (vc-append (* gap-size 2)
    (vc-append
      (category "Availablity")
      (name "Hystrix (2666 stars)")
      (name "Simianarmy (2327 stars)")
      (name "Turbine")
    )
    (vc-append
      (category "Cloud Management")
      (name "Ice (1123 stars)")
      (name "Asgard (1574 stars)")
      (name "Frigga")
      (name "Glisten")
    )
    (vc-append
      (category "Persistence Systems")
      (name "Astyanax")
      (name "Cassjmeter")
      (name "Curator")
      (name "Evcache")
      (name "Exhibitor")
      (name "Priam")
      (name "Staash")
      (name "Dynomite")
      (name "Dyno")
      (name "Raigad")
    )
  )
  (vc-append (* gap-size 1)
    (vc-append
      (category "In-Memory Data Management")
      (name "Netflix-graph")
      (name "Zeno")
    )
    (vc-append
      (category "Platform Libraries")
      (name "Archaius")
      (name "Denominator")
      (name "Feign")
      (name "Karyon")
      (name "Ribbon")
      (name "Servo")
      (name "Blitz4j")
      (name "Governator")
    )
    (vc-append
      (category "Infrastructure Services")
      (name "Atlas")
      (name "Edda")
      (name "Suro")
      (name "Eureka")
      (name "Zuul")
      (name "Prana")
    )
    (vc-append
      (category "Developer Productivity")
      (name "Gcviz")
      (name "Pytheas")
    )
    (vc-append
      (category "Sample Applications and recipes")
      (name "Recipes-rss")
    )
  )
  (vc-append (* gap-size 2)
    (vc-append
      (category "Big Data Tools")
      (name "Aegisthus")
      (name "Genie")
      (name "Inviso")
      (name "Lipstick")
      (name "Pigpen")
      (name "S3mper")
    )
    (vc-append
      (category "Build and Deploy Tools")
      (name "Aminator")
    )
    (vc-append
      (category "Security")
      (name "Msl")
      (name "Scumblr")
      (name "Security_monkey")
      (name "Sketchy")
    )
    (vc-append
      (category "Others")
      (name "Nfwebcrypto")
      (name "Brutal")
    )
  )
)

(top-bottom-panel
  (s "Case Studies" 60)
  (ht-append (* gap-size 3)
    (vl-append
      (t "No QA department")
      (t "No release engineer")
      (t "Internal PaaS")
      (t "Root cause analysis meeting")
    )
    (vl-append
      (t "Asgard")
      (t "Eureka")
      (t "SimianArmy")
      (t "")
      (t "Archaius")
      (t "Ice")
    )
  )
)

(slide
  (t "http://netflix.github.io")
  (t "http://techblog.netflix.com/")
  (t "http://www.infoq.com/cn/news/2013/06/netflix")
)
