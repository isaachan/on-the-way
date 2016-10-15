#lang slideshow

(require "../utils/common.el")

(title "Docker Network")

(slide #:title "Third-party Solution"
  (vc-append (* gap-size 1.5)
    (s "Pipework" 30)
    (s "Weave" 30)
    (s "Flannel" 30)
    (s "SocketPlane" 30)
  )
)

(topic "Libnetwork - CNM")

(top-bottom-panel
  (scale (bitmap "./cnm.jpg") 1.5)
  (vl-append (* gap-size 1.5)
    (s "Sandbox (Linux Network namespace)" 30)
    (s "Endpoint - veth pair or OVS internal port" 30)
    (s "Network" 30)
  )
)
