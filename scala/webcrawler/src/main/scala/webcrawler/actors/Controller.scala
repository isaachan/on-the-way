package webcrawler.actors

import akka.actor._
import akka.pattern._
import java.util.concurrent.Executor
import scala.util._
import scala.concurrent._
import scala.concurrent.duration._
import webcrawler._

object Controller {
  case class Check(link:String, depth:Int)
  case class Result(cache:Set[String])
  case class Timeout
}

class Controller extends Actor with ActorLogging {

  context.setReceiveTimeout(10.seconds)  

  var cache = Set.empty[String]
  var children = Set.empty[ActorRef]
 
  import context.dispatcher
  context.system.scheduler.scheduleOnce(10.seconds, self, Controller.Timeout) 

  def receive = {
    case Controller.Check(url, depth) =>
      log.debug("{} checking {}", depth, url)
      if (!cache(url) && depth > 0)
        children += context.actorOf(Props(new Getter(url, depth - 1)))
      cache += url
    case Getter.Done =>
      children -= sender
      if (children.isEmpty) context.parent ! Controller.Result(cache)
    case ReceiveTimeout => children foreach (_ ! Getter.Abort)
    case Controller.Timeout => children foreach (_ ! Getter.Abort)
  }

}
