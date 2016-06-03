#!/bin/bash
/usr/local/spark/bin/spark-submit --class "org.myspark.LogReg" --master local[4] build/libs/spark_log_reg.jar

