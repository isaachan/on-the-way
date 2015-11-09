package vmmonitor.actors

import akka.actor.Actor
import akka.actor.Props

import vmmonitor.actors.GetterActor._

case class Check

class CheckerActor(name: String) extends Actor {

  def receive: Receive = {
    case Check => {
      println("Check VM from " + name)
      context.actorOf(Props[GetterActor])
    }
  }

}
