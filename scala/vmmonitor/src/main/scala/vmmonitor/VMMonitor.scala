package vmmonitor

import scala.concurrent._
import scala.collection.mutable.ArrayBuffer
import scala.concurrent.duration._
import akka.actor.Actor
import akka.actor.Props
import akka.actor.ActorSystem
import vmmonitor.actors.MasterActor
import ExecutionContext.Implicits.global

case class Monitor

object VMMonitorApplication extends App {

  val system = ActorSystem("VMMonitor")

  val master = system.actorOf(Props[MasterActor], name = "master")

  system.scheduler.schedule(0 seconds, 5 seconds, master, Monitor)

}
