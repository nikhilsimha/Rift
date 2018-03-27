
#Rift

> *"The ability to simplify means to eliminate the unnecessary so that the necessary may speak."* 
>                              - Hans Hofmann
 

The goal of this framework is to simplify the process of authoring statically distributed services and data pipelines- 
by allowing the user to specify business logic as SQL alongside schema definition.     



In this current iteration we plan to support sql queries over collections of [FlatBuffer](http://google.github.io/flatbuffers/)
objects. 


#### SQL
This is a dialect of SQL that is type-checked against flatbuffer schemas - so a compiler can tell you if your query 
returns a result that matches the result type expected by the service method.

Here are a list of extensions to the language.
- UDF's / mapper
- UDAF's / reducer
- UDTF's / flatMapper
- Structs
- JSON access methods
- Table generation methods - from RPC calls and constants.

One thing to note is that, we deliberately omit CREATE statements from the language, and ask that the user exclusively uses
flatbuffer schema definitions in their place.


#### Processing Modes

- OLTP - data in a key-value type store(rocksDB)
- OLAP - un-keyed persistent storage(columnar - parquet)
- Stream Processing - from streaming sources (kafka)

The user can mix and match queries across different modes to create services backed by data pipelines - by simply changing
the annotation on the query.



