package vmmonitor.actors

import akka.actor.Actor
import akka.actor.ActorRef
import akka.actor.Props
import akka.routing.RoundRobinRouter
import vmmonitor._
import vmmonitor.actors._
import scala.util._

class MasterActor extends Actor {

  val checkers  = createCheckers

  def receive: Receive = {
    case Monitor => {
      println("Begin checking VMs")
      for (c <- checkers) { c ! Check }
    }
  } 

  def createCheckers: Set[ActorRef] = {
    var checkers = Set.empty[ActorRef]
    for (i <- 1 to 10) {
      val name = "checker-" + i
      val c = context.actorOf(Props(new CheckerActor(name)), name)
      checkers = checkers + c
    }

    println("Number of checkers: " + checkers.size)
    return checkers
  }
  
}
