FROM bde2020/flink-base:1.4.1-hadoop2.7

MAINTAINER Daniel Obraczka <obraczka@studserv.uni-leipzig.de>

ADD worker.sh /

ENV FLINK_JOBMANAGER_RPC_PORT ""
ENV FLINK_JOBMANAGER_HEAP_MB ""
ENV FLINK_TASKMANAGER_HEAP_MB ""
ENV FLINK_NUMBER_OF_TASK_SLOTS ""
ENV FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION ""
ENV FLINK_TASKMANAGER_NETWORK_MEMORY_MIN ""
ENV FLINK_TASKMANAGER_NETWORK_MEMORY_MAX ""
ENV FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS ""
ENV FLINK_TASKMANAGER_MEMORY_SIZE ""
ENV FLINK_TASKMANAGER_MEMORY_FRACTION ""
ENV FLINK_JAVA_OPTS ""

EXPOSE 8081

CMD ["/bin/bash", "/worker.sh"]

