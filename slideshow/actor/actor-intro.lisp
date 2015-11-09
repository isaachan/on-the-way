#lang slideshow

(require "../utils/common.rkt")

(define title2
  (lambda content
    (slide (vr-append (* gap-size 5)
             (vc-append 
               (* gap-size 3)
               (s (car content) 64)
             )
             (vr-append (* gap-size 0.5)
                (text "Li Xin, Han Kai" (cons 'bold (current-main-font)) 32)
		(hc-append 
                  (text "Thought" (cons 'bold (current-main-font)) 24)
                  (text "Works" (current-main-font) 24)
                )
             )
	   )
    )
  )
)

(title2 "Akka in Action")

(slide
  (t "Actor model")
  'next
  (t "Asynchronous message passing")
  'next  
  (t "Event-driven")
  'next  
  (t "'let-it-crash'")
  'next  
  (t "Location transparency")
  'next  
  (t "Java/Scala API")
)

(topic "History of Actor")

(slide
  (vl-append (* gap-size 1)
    (t "1973, Carl Hewitt et al")
    (t "1986, Gul Agha, Actor language and patterns")
    (t "1995, Erisson, Erlang/OTP for telecommunication platform")
    (t "2006, Philipp Haller, Scala implementation")
    (t "2009, Jonas Boner, creation of Akka")
  )
)

(left-right-panel
  (t "An Actor...")
  (vl-append
    (t "is a object,")
    (t "")
    (t "has a behavior,")
    (t "")
    (t "only interacts using")
    (t "   asynchronous message passing.")    
  )
)

(define (scala-code str) (text str 'modern (current-font-size)))

(top-bottom-panel
  (s "A simple Actor" 45)
  (vl-append (* gap-size 0.3)
    (scala-code "class Counter extends Actor {")
    (scala-code "  var count = 0")
    (scala-code "  def receive = {")
    (scala-code "    case 'incr' => count + 1")
    (scala-code "    case 'get'  => sender ! count")
    (scala-code "  }")
    (scala-code "}")
  )
)

(slide
  (vl-append (* gap-size 0.3)
    (scala-code "class Master extends Actor {")
    (scala-code "  val counter = context.actorOf(Props[Counter])")
    (scala-code "  ")
    (scala-code "  counter ! incr")
    (scala-code "  counter ! incr")
    (scala-code "  counter ! incr")
    (scala-code "  counter ! get")
    (scala-code "  ")
    (scala-code "  def receive = {")
    (scala-code "    case count:Int => ")
    (scala-code "      println(s'count is $count')")
    (scala-code "      context.stop(self)")
    (scala-code "  }")
    (scala-code "}")
    (scala-code "")
  )
)

(left-right-panel
  (s "Work with Actors" 45)
  (vl-append (* gap-size 2)
    (s "Create Actors" 30)
    (s "Send messages" 30)
    (s "Designate the behaivor of next message" 30)
  )
)

(topic "MapReduce - Work count")
(top-bottom-panel
  (vl-append (* gap-size 1.5)
    (t "The quick brown fox tried to jump over the lazy dog and fell on the dog")
    (t "Dog is man's best friend")
    (t "Dog and Fox belong to the same family")
  )
  (hc-append (* gap-size 3)
    (vr-append
      (t "best -> 1")
      (t "brown -> 1")
      (t "jump -> 1")
      (t "fell -> 1")
      (t "fox -> 2")
    )
    (vr-append
      (t "belong -> 1")
      (t "over -> 1")
      (t "quick -> 1")
      (t "family -> 1")
      (t "dog -> 4")
    )
    (vr-append
      (t "man's -> 1")
      (t "same -> 1")
      (t "lazy -> 1")
      (t "tried -> 1")
      (t "friend -> 1")
    )
  )
)

(top-bottom-panel
  (s "Solution 1" 60)
  (t "")
)

(top-bottom-panel
  (s "Solution 1" 60)
  (vl-append
    (s "Single thread" 30)
    (s "Lack of scalability" 30)    
  )
)

(top-bottom-panel
  (s "Solution 2" 60)
  (t "")
)

(top-bottom-panel
  (s "Solution 2" 60)
  (vl-append
    (s "Multiple threads" 30)
    (s "Synchronization" 30)
    (s "Data race" 30)
    (s "Shared memory" 30)
  )
)

(top-bottom-panel
  (s "Solution 3" 60)
  (vc-append (* gap-size 3)
    (s "Build upon Akka" 50)
    (s "  start from Actors ..." 30)
  )
)

(slide
  (scale 
  (bitmap "mapreduce.dot.png")
  1)
)

(slide
  (vl-append (* gap-size 0.3)
    (scala-code "class Map extends Actor {")
    (scala-code "  def receive = {")
    (scala-code "    case message:String => ")
    (scala-code "      sender ! evaluateExpression(message)")
    (scala-code "  }")
    (scala-code "  ")
    (scala-code "  def evaluateExpression(line:String): MapData = {")
    (scala-code "    line.split(\\s+).foldLeft(")
    (scala-code "           ArrayBuffer.empty[WordCount]) {")    
    (scala-code "      (index, word) =>")
    (scala-code "         index += WordCount(word.toLowerCase, 1)")
    (scala-code "  }")
    (scala-code "}")
  )
)

(slide
  (vl-append (* gap-size 0.3)
    (scala-code "class Reducer extends Actor {")
    (scala-code "  def receive = {")
    (scala-code "    case MapData(dataList) => ")
    (scala-code "      sender ! reduce(dataList)")
    (scala-code "  }")
    (scala-code "  ")
    (scala-code "  def reduce(words: Seq[WordCount]):ReduceData=")
    (scala-code "    // reducation code ")
    (scala-code "  }")
    (scala-code "}")
  )
)

(slide
  (vl-append (* gap-size 0.3)
    (scala-code "class Aggregator extends Actor {")
    (scala-code "  val finalReduceMap = new HashMap")
    (scala-code "  def receive = {")
    (scala-code "    case ReduceData(reduceDataMap) => ")
    (scala-code "      aggreateInMemory(reduceDataMap)")
    (scala-code "    case Result =>")
    (scala-code "      sender ! finalReduceMap.toString()")
    (scala-code "  }")
    (scala-code "}")
  )
)

(slide
  (vl-append (* gap-size 0.3)
    (scala-code "class Master extends Actor {")
    (scala-code "  ... ")
    (scala-code "  def receive: Receive = {")
    (scala-code "    case line: String => ")
    (scala-code "        mapActor ! line")
    (scala-code "    case mapData: MapData => ")
    (scala-code "        reduceActor ! mapData")
    (scala-code "    case reduceData: ReduceData => ")
    (scala-code "        aggregateActor ! reduceData")
    (scala-code "    case Result => aggregateActor forward Result")    
    (scala-code "  }")
    (scala-code "}")
  )
)

(slide
  (scale 
  (bitmap "mapreduce.dot.png")
  1)
)

(top-bottom-panel
  (s "Web crawler" 60)
  (scale (bitmap "webcrawler.jpg") 0.3)
)

(slide (scale (bitmap "links.dot.png") 1.5))

(slide (scale (bitmap "p.dot.png") 1.5))
(slide (scale (bitmap "p.dot.2.png") 1.5))
(slide (scale (bitmap "p.dot.3.png") 1.5))
(slide (scale (bitmap "p.dot.4.png") 1.5))
(slide (scale (bitmap "p.dot.5.png") 1.5))
(slide (scale (bitmap "p.dot.6.png") 1.5))
(slide (scale (bitmap "p.dot.7.png") 1.5))
(slide (scale (bitmap "p.dot.8.png") 1.5))
(slide (scale (bitmap "p.dot.9.png") 1.5))
(slide (scale (bitmap "p.dot.10.png") 1.5))
(slide (scale (bitmap "p.dot.11.png") 1.5))
(slide (scale (bitmap "p.dot.12.png") 1.5))

(topic "Demo")

(slide
  #:title "Build large scale enterprise application"

  (t "Supervision & Monitor")
  'next
  (t "Distribution & Remoting")
  'next
  (t "Routing & Partitioning")
  'next
  (t "Unit test")
 )

(topic "Thanks")
