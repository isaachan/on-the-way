package webcrawler

import com.ning.http.client._
import com.ning.http.client._
import scala.concurrent._
import scala.concurrent.duration._
import akka.actor._
import akka.pattern.pipe
import java.util.concurrent.Executor
import scala.util._

case class BadStatus(statusCode: Int) extends Exception

object WebClient {

  val client = new AsyncHttpClient

  def get(url:String)(implicit exec: Executor): Future[String] = {
    val f = client.prepareGet(url).execute();
    val p = Promise[String]()
    f.addListener(new Runnable {
      def run = {
        val response = f.get
        if (response.getStatusCode < 400)
          p.success(response.getResponseBodyExcerpt(131072))
        else p.failure(new Exception("" + response.getStatusCode))
      }
    }, exec)
    
    p.future
  }

}
