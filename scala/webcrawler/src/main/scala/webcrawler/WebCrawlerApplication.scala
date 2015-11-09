package webcrawler

import akka.actor.Actor
import akka.actor.Props
import akka.actor.ActorSystem
import webcrawler.actors._

object MapReduceApplication extends App {
  val _system = ActorSystem("WebCrawler")

  val master = _system.actorOf(Props[Master])

  Thread.sleep(16000)

  _system.shutdown
}
