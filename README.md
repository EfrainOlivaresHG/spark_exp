# spark_exp

# source examples from [spark examples](http://spark.apache.org/examples.html)

### Apache Spark Examples
These examples give a quick overview of the Spark API. Spark is built on the concept of distributed datasets, which
contain arbitrary Java or Python objects. You create a dataset from external data, then apply parallel operations to
it. The building block of the Spark API is its RDD API. 

In the RDD API, there are two types of operations: 
* transformations, which define a new dataset based on previous ones
* kick off a job to execute on a cluster.

On top of Spark’s RDD API, high level APIs are provided, e.g.
* DataFrame API
* Machine Learning
API. These high level APIs provide a concise way to conduct certain data operations.

In this page, we will show
examples using RDD API as well as examples using high level APIs.

