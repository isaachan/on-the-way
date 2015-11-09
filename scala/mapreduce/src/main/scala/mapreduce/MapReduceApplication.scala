package mapreduce

import scala.collection.mutable.ArrayBuffer
import scala.collection.immutable.Map

import akka.actor.Actor
import akka.actor.Props
import akka.actor.ActorSystem
import akka.actor.actorRef2Scala
import akka.util.Timeout
import akka.util.duration.intToDurationInt
import akka.pattern.ask
import akka.dispatch.Await

import mapreduce.actors.MasterActor

sealed trait MapReduceMessage
case class WordCount(word: String, count: Int) extends MapReduceMessage
case class MapData(dataList: ArrayBuffer[WordCount]) extends MapReduceMessage
case class ReduceData(reduceDataMap: Map[String, Int]) extends MapReduceMessage
case class Result extends MapReduceMessage

object MapReduceApplication extends App {
  val _system = ActorSystem("MapReduceApp")
  val master = _system.actorOf(Props[MasterActor], name = "master")
  implicit val timeout = Timeout(5 seconds)
  master ! "The quick brown fox tried to jump over the lazy dog and fell on the dog"
  master ! "Dog is man's best friend"
  master ! "Dog and Fox belong to the same family"
  
  Thread.sleep(500)
  val future = (master ? Result).mapTo[String]
  val result = Await.result(future, timeout.duration)
  println(result)
  _system.shutdown
}
