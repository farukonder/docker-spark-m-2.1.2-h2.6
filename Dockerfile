FROM java:openjdk-8-jdk

ENV spark_ver 2.1.0

# Get Spark from US Apache mirror.
RUN mkdir -p /opt && \
    cd /opt && \
	curl http://www.us.apache.org/dist/spark/spark-${spark_ver}/spark-${spark_ver}-bin-hadoop2.6.tgz | \
	tar -zx && \
    ln -s spark-${spark_ver}-bin-hadoop2.6 spark && \
    echo Spark ${spark_ver} installed in /opt

RUN unset SPARK_MASTER_PORT &&\
	echo "$(hostname -i) spark-master" >> /etc/hosts &&\
	/opt/spark/sbin/start-master.sh --ip spark-master --port 7077
	
ENV PATH $PATH:/opt/spark/bin