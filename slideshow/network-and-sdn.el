#lang slideshow

;
; From a great series of blogs:
;  https://community.emc.com/thread/197851
;

(require "utils/common.el")

(title "Network and SDN")

(define (bt content) (text content "Helvetica" 32))

(top-bottom-panel
  (scale (bitmap "images/network-protocol-encapsulation-terms.jpg") 2.2 1.2)
  (hc-append (* gap-size 2)
    (vl-append (* gap-size 0.5)
      (t "Protocal Data Unit in Different Layers")
      (s "  - Data (Application)" 24)
      (s "  - Segment, Packet (Transport)" 24)
      (s "  - Frame (Network)" 24)
      (s "  - Bit (Link)" 24)
    )
    (scale (bitmap "images/network-pdu.jpg") 0.8 0.8)
  )
  cc-superimpose
  lc-superimpose
)

(define question
  (lambda questionContent
    (top-bottom-panel
      (colorize (text "Question?" (cons 'bold "Hevetica") 42) "red")
      (para questionContent)
      cc-superimpose
      ct-superimpose
    )
  ) 
)

(question "There are many network devices, Switch, Gateway, Router, Netword Card, Bridge, etc. Which OSI layer they are working on?")

(topic "Access Local Resource")

(top-bottom-panel
  (scale (bitmap "images/network-communicating-with-a-device-on-the-same-network.jpg") 2 1)
  (vl-append (* gap-size 0.5)
    (t "Network layer address (IP address)")
    (s "  - DNS can find IP" 24)
    (s "  - User can type IP address directly" 24)
    (t "Data link layer address (MAC address)")
    (s "  - ARP protocol can tell target MAC" 24)
    (s "  - ARP is a boradcast requst" 24)
    (s "    (If your ip is 10.18.3.1, please tell me your mac address!)" 24)
  )
  cc-superimpose
  lc-superimpose
)

(topic "Access Remote Resource")

(slide
  (tbp 
    (scale (bitmap "images/network-access-remote-resource.jpg") 2 1)
    (vl-append (* gap-size 0.5)
      (t "Default gateway")
      (t "Destination MAC address")
      (s "  - Default gateway" 24)
      (t "How to get destination MAC address?")
      (s "  - Get default route IP from configuration" 24)
      (s "  - Get MAC via ARP" 24)
    )
    cc-superimpose
    lc-superimpose
  )
  (comment "Default gateway is needed for access remote resource\n'route -n' to check your default gateway")
)

(question "There are many 192.168.* and 10.* LAN, but how to distinguish them in internet?")

(topic "Swtich")

(slide
  #:title "Siwtch (.nonm)"
  (vl-append (* gap-size 0.8)
    (para "Get source MAC address from frame, and transfer to diestionation MAC address.")
    (t "Ingress & Destination")
    (t "Address table:")
    (s "  PORT A => MAC of PC X" 24)
    (s "  PORT B => MAC of PC Y" 24)
    (s "  PORT C => MAC of PC Z" 24)
  )
)

(define three-top-three-bottom
  (lambda (t1 t2 t3 b1 b2 b3)
    (slide
      (vc-append
        (cc-superimpose
          (blank client-w (/ client-h 2))
          (ht-append (* gap-size 0.3)
            (cc-superimpose (blank (/ client-w 3) (/ client-h 2)) t1)
            (cc-superimpose (blank (/ client-w 3) (/ client-h 2)) t2)
	    (cc-superimpose (blank (/ client-w 3) (/ client-h 2)) t3)
          )
        )
        (cc-superimpose
          (blank client-w (/ client-h 2))
          (ht-append (* gap-size 0.3)
            (cc-superimpose (blank (/ client-w 3) (/ client-h 2)) b1)
            (cc-superimpose (blank (/ client-w 3) (/ client-h 2)) b2)
            (cc-superimpose (blank (/ client-w 3) (/ client-h 2)) b3)
          )
        )
      )
    )  
  )
)

(three-top-three-bottom
  (scale (bitmap "images/network-switch-transfer-1.jpg") 0.6 0.7)
  (scale (bitmap "images/network-switch-transfer-2.jpg") 0.6 0.7)
  (scale (bitmap "images/network-switch-transfer-3.jpg") 0.6 0.7)
  (scale (bitmap "images/network-switch-transfer-4.jpg") 0.6 0.7)
  (scale (bitmap "images/network-switch-transfer-5.jpg") 0.6 0.7)
  (scale (bitmap "images/network-switch-transfer-6.jpg") 0.6 0.7)
)

(slide
  #:title "Switch data transfer"
  (vl-append (* gap-size 0.5)
    (text "Store-and-Forward" (cons 'bold (current-main-font)) 32)
    (s " - Store the entire frame before forwarding" 24)
    (s " - Ability to check & validate" 24)
    (s " - Auto cache, mix connect to ether networks with different bandwidth" 24)
    (s " - Adequate for large-scaled LAN" 24)
    (text "Cut-Through" (cons 'bold (current-main-font)) 32)
    (s " - Fast, without validation" 24)
    (s " - Waste bandwidth when huge broken frames occured" 24)
    (text "Fragment Free" (cons 'bold (current-main-font)) 32)
    (s " - Improvement of Cut-Through" 24)
    (s " - Check if one frame if larger than 64 byte" 24)
    (s " - Adequate for HPC" 24)
  )
)

(question "Two PCs, PC 1 has IP '192.168.1.1', PC 2 has IP '192.168.2.1'. Is it possiable that PC 1 ping PC 2?")

(topic "VLAN")

(top-bottom-panel
  (scale (bitmap "images/network-why-vlan.jpg") 1.5 1.2)
  (vl-append (* gap-size 0.5)
    (s "Why vlan?" 32)
    (s " - Broadcast decrease performance" 24)
    (s " - To reduce broadcase domain and improve performance" 24)
    (s " - For security" 24)
    (s " - To simplify IT management" 24)
    (s " - Reduce the cost of IT" 24)
  )
  cc-superimpose
  lc-superimpose
)

(slide
  (tbp
    (hc-append (* gap-size 0.5)
      (scale (bitmap "images/network-route-switch-1.jpg") 0.9)
      (scale (bitmap "images/network-route-switch-2.jpg") 0.8)
    )
    (vl-append (* gap-size 0.5)
      (s "Two switchs with same VLAN, and non-local data must be transfered via router" 24)
      (s "Router never transfer unicast, mulitcase, and broadcase in layer-two" 24)
      (text "If we ged red of one switch, and add one more VLAN in another switch ..." (cons 'bold (current-main-font)) 24)
      (s "Locally, they have the same topology structure" 24)
    )
    cc-superimpose
    lc-superimpose
  )
  (comment "每一个VLAN相当于一个独立的三层IP网络，因此，192.168.1.0上的节点试图与192.168.2.0上的节点通信时，不同VLAN通信必须通过路由器，即使所有设备都连接到同一交换机。二层单播，多播和广播数据只会在同一VLAN内转发及泛洪，因此VLAN 1产生的数据不会为VLAN 2节点所见。只有交换机能看得到VLAN，节点和路由器都感觉不到VLAN的存在。添加了路由决策之后，可以利用3层的功能来实现更多的安全设定，更多流量以及负载均衡。")
)

(topic "VLAN and Trunk" "VLAN cross multiple switchs")

(top-bottom-panel
  (scale (bitmap "images/network-vlan-with-multi-switchs-1.jpg") 1.3)
  (para "Two switchs have the smame VLAN - 'VLAN 1', and router is the unity ponit to outside world. PC 1-4 can access each other freely, because they are all in same VLAN, than unicast, multicase and broadcase can be transfered without obstacle.")
)

(top-bottom-panel
  (scale (bitmap "images/network-vlan-with-multi-switchs-2.jpg") 1.2)
  (vl-append (* gap-size 0.5)
    (colorize (t "Each single node CAN NOT communicate with each other !!") "red")
    (s "  - Three VLANs" 24)
    (s "  - Two switchs connect by different VLANs (VLAN 1 and VLAN 3)" 24)
    (s "  - Router connects to VLAN 1" 24)
  )
  cc-superimpose
  lt-superimpose
)

(slide 
  (tbp
    (scale (bitmap "images/network-vlan-with-multi-switchs-3.jpg") 1.2)
    (vl-append (* gap-size 0.5)
      (t "'Trunk' is needed to resolve the issue")
      (s "  - Carrying multiple VLANs through a single network linkocol" 24)
      (s "  - To allow for multiple VLANs on one link, " 24)
      (s "     frames from individual VLANs must be identified" 24)
    )
    cc-superimpose
    lc-superimpose
  )
  (comment "当安装好trunk线之后，帧在trunk线传输是就可以使用trunk协议来修改以太网帧。这也意味着交换机端口有不止一种操作模式。缺省情况下，所有端口都称为接入端口。当一个端口用于交换机间互连传输VLAN信息时，这种端口模式改变为trunk，节点也路由器通常不知道VLAN的存在并使用标准以太网帧或“untagged”帧。trunk线能够使用“tagged”帧来标记VLAN或优先级。")
)

(slide 
  (tbp
    (scale (bitmap "images/network-vlan-with-multi-switchs-4.jpg") 1.4)
    (vl-append (* gap-size 0.5)
      (t "How PC 1 send data to PC 2:")
      (s " 1. Ether frames are leaving PC 1 to Switch 1" 24)
      (s " 2. Switch 1 identified the destination is on another side of trunk" 24)
      (s " 3. Switch 1 append VLAN id to frames (trunk protocol)" 24)
      (s " 4. Frames leave Switch 1 to Switch 2 (via trunk)" 24)
      (s " 5. Switch 2 parse frames (trunk protocol)" 24)
      (s " 6. Switch 2 transfers data to PC 2" 24)
    )
    cc-superimpose
    lc-superimpose
  )
)
 
(question "Why we call trunk 'trunk'?")

(topic "Router")

(slide
  (tbp
    (scale (bitmap "images/network-router-sample.jpg") 1.5 1)
    (vl-append (* gap-size 0.2)
      (t "Routers work with layer-3 data, but switchs layer-2")
      (t "Switchs transfer data within same network")
      (t "Routers transfer data cross networks")
      (t "During the entire process from source to end:")
      (vl-append 
        (s " - layer-3 address changes every hop" 24)
        (s " - layer-2 address never change" 24)
      )
    )
    cc-superimpose
    lc-superimpose
  )
  (comment "demo whole process on writeborad")
)

(slide
  #:title "Route table"
  (vl-append (* gap-size 0.5)
    (t "Static table")
    (t "Dynamic table")
  )
  (comment "路由表能力是指路由表内所容纳路由表项数量的极限。由于Internet上执行BGP协议的路由器通常拥有数十万条路由表项，所以该项目也是路由器能力的重要体现。")
)


