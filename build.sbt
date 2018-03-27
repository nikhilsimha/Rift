name := "Rift"

version := "0.1"

scalaVersion := "2.12.5"

// sbt 1.1.x
enablePlugins(Antlr4Plugin)

antlr4Version in Antlr4 := "4.7.1"

libraryDependencies += "org.rocksdb" % "rocksdbjni" % "3.6.2"
libraryDependencies += "com.google.flatbuffers" % "flatbuffers-java" % "1.8.0"
libraryDependencies += "com.google.flatbuffers" % "flatbuffers-java-grpc" % "1.8.0"
