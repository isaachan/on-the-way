package webcrawler.actors

import akka.actor._
import akka.pattern._
import java.util.concurrent.Executor
import scala.util._
import scala.concurrent._
import webcrawler._

object Getter {
  case class Done
  case class Abort
}

class Getter(url: String, depth: Int) extends Actor {
  implicit val exec =
    context.dispatcher.asInstanceOf[Executor with ExecutionContext]
  
  /*
  val future = WebClient.get(url)
  future onComplete {
    case Success(body) => self ! body
    case Failure(err)  => self ! Status.Failure(err)
  }
  */
  WebClient get url pipeTo self

  def receive = {
    case body:String =>
      for (link <- findLinks(body))
        context.parent ! Controller.Check(link, depth)
      stop()
    case _:Status.Failure => stop()
    case Getter.Abort => stop()
  }

  def stop(): Unit = {
    context.parent ! Getter.Done
    context.stop(self)
  }

  val A_TAG = "(?i)<a ([^>]+)>.+?</a>".r
  val HREF_ATTR = """\s*(?i)href\s*=\s*(?:"([^"]*)"|’([^’]*)'|([^'">\s]+))""".r

  def findLinks(body: String): Iterator[String] = {
    for {
      anchor <- A_TAG.findAllMatchIn(body)
      HREF_ATTR(dquot, quot, bare) <- anchor.subgroups
    } yield
      if (dquot != null) dquot
      else if (quot != null) quot
      else bare
  }
  
}
