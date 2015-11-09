package webcrawler.actors

import akka.actor._
import akka.pattern._
import java.util.concurrent.Executor
import scala.util._
import scala.concurrent._
import scala.concurrent.duration._
import webcrawler._

object Receptionist {
  case class Failed(url: String)
  case class Get(url: String)
  case class Result(url: String, links: Set[String])
}

class Receptionist extends Actor {

  def receive = waiting

  val waiting:Receive = {
    case Receptionist.Get(url) => context.become(runNext(Vector(Job(sender, url))))
  }

  def running(queue: Vector[Job]):Receive = {
    case Controller.Result(links) =>
      val job = queue.head
      job.client ! Receptionist.Result(job.url, links)
      context.stop(sender)
      context.become(runNext(queue.tail))
    case Receptionist.Get(url) =>
      context.become(enqueueJob(queue, Job(sender, url)))
  }

  case class Job(client:ActorRef, url:String)

  var reqNo = 0

  def runNext(queue:Vector[Job]):Receive = {
    reqNo += 1
    if (queue.isEmpty) waiting
    else {
      val controller = context.actorOf(Props[Controller], s"c$reqNo")
      controller ! Controller.Check(queue.head.url, 2)
      running(queue)
    }
  }

  def enqueueJob(queue:Vector[Job], job:Job):Receive = {
    if (queue.size > 3) {
      sender ! Receptionist.Failed(job.url)
      running(queue)
    } else running(queue :+ job)
  }
}
