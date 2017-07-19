#! /usr/local/bin/amm

import ammonite.ops._
import ammonite.ops.ImplicitWd._

import $ivy.`com.github.pathikrit::better-files:3.0.0`
@
import better.files._
import java.io.{File => JFile}

lazy val tag: String = "c251f79c6bde3dce12e685c6cf03d5b1c30e9273--4e4d61f3cdc33b5978dd028151e7a2f5027ffa9d"
lazy val network: String = "bigdatadocker_default"
lazy val adamPort = 9999

/*
docker run \
       --net=host \
       -p 9999:9999 \
       quay.io/ucsc_cgl/adam:latest \
       --master spark://<spark_master_ip>:7077 \
       --conf spark.driver.port=9999 -- \
       flagstat hdfs://<hdfs_master_ip>:8020/mouse_chrM.bam
*/

def getPath(path: String): String = if(path.startsWith("hdfs:") || path.startsWith("file:")) path
	else s"hdfs://namenode:8020/${path}"

@main
def fasta2adam(fasta: String, adam: String, fragment_length: Int = 1000000, net: String = network, folder: Path = pwd) = {
	val container = s"docker run -p ${adamPort}:${adamPort} --net=${net} -v ${folder.toString}:/data quay.io/ucsc_cgl/adam:${tag}"
	val f: String = getPath(fasta)
	val a: String = getPath(adam)
	val sparkArgs = s"--master spark://spark-master:7077 --conf spark.driver.port=${adamPort} --"
	val params = s"${sparkArgs} fasta2adam ${f} ${a} -fragment_length ${fragment_length}"
	val str = container + " " + params
	println("---running---")
	println(str)
	println("")

	%docker("run",  "-p", s"${adamPort}:${adamPort}",
				s"--net=${net}",
				"-v", s"${folder.toString}:/data",
				s"quay.io/ucsc_cgl/adam:${tag}",
				//s"--master", "spark://spark-master:7077",
				sparkArgs,
				s"fasta2adam", f, a,
				"-fragment_length", fragment_length
	)
}

@main
def flagstat(path: String, net: String = network, folder: Path = pwd) = {
	val container = s"docker run -p ${adamPort}:${adamPort} --net=${net} -v ${folder.toString}:/data quay.io/ucsc_cgl/adam:${tag}"
	val params = s"flagstat hdfs://namenode:8020/${path}"
	val str = container + " " + params
	println("---running---")
	println(str)
	println("")
	val p: String = getPath(path)
	%docker("run",  "-p", s"${adamPort}:${adamPort}",
				s"--net=${net}",
				"-v", s"${folder.toString}:/data",
				s"quay.io/ucsc_cgl/adam:${tag}",
				//s"-- master spark://spark-master:7077 --",
				//s"--conf", s"spark.driver.port=${adamPort} --",
				s"flagstat", p
	)
}

@main
def adam(command: String, net: String = network, folder: Path = pwd) = {
	%docker("run",  "-p", s"${adamPort}:${adamPort}",
				s"--net=${net}",
        "-v", s"${folder.toString}:/data",
				s"quay.io/ucsc_cgl/adam:${tag}",
				s"--conf spark.driver.port=${adamPort}",
				command
	)
	//docker run --name some-mysql -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
}
