FROM openjdk:7-jre-alpine

ARG SPARK_VERSION=2.0.2
ARG HADOOP_VERSION_MAJOR=2.7
ARG EXECUTOR_URI_PATH
RUN apk add --no-cache bash && rm -rf /var/cache/apk/*

RUN mkdir /opt/
RUN mkdir /opt/spark
WORKDIR /opt/spark

RUN \
  wget http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_MAJOR}.tgz && \
  tar -zxf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_MAJOR}.tgz 

ENV PATH /opt/spark/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_MAJOR}/bin:$PATH

COPY spark-defaults.conf /opt/spark/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_MAJOR}/conf/
RUN echo spark.executor.uri ${EXECUTOR_URI_PATH}spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_MAJOR}.tgz >> /opt/spark/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_MAJOR}/conf/spark-defaults.conf

VOLUME ["/root/project"]

WORKDIR /root/project/

# note: not --login b/c that overwrites the environment for the resultant session with the
# default environment for bash (e.g., w/o path that knows where spark is)
#CMD ["/bin/bash", "--login"]
CMD ["/bin/bash"]
