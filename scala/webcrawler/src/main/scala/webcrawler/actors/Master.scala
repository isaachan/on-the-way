package webcrawler.actors

import scala.concurrent.duration._
import akka.actor._
import webcrawler._
import webcrawler.actors._

class Master extends Actor {

  import webcrawler.actors.Receptionist._

  val receptionist = context.actorOf(Props[Receptionist], "receptionist")

  receptionist ! Get("http://www.baidu.com")

  context.setReceiveTimeout(10.seconds)

  def receive = {
    case Result(url, set) =>
      println(set.toVector.sorted.mkString(s"Results for '$url': \n", "\n", "\n"))
    case Failed(url) =>
      println(s"Failed to fetch '$url'\n")
    case ReceiveTimeout =>
      context.stop(self)
  }

}
