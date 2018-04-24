#!/bin/bash

echo "Configuring Job Manager on this node"

sed -i -e "s/jobmanager.rpc.address: localhost/jobmanager.rpc.address: `hostname -i`/g" /usr/local/flink/conf/flink-conf.yaml

sed -i -e "s/jobmanager.rpc.port: 6123/jobmanager.rp.port: ${FLINK_JOBMANAGER_RPC_PORT}/g" /usr/local/flink/conf/flink-conf.yaml
sed -i -e "s/jobmanager.heap.mb: 1024/jobmanager.heap.mb: ${FLINK_JOBMANAGER_HEAP_MB}/g" /usr/local/flink/conf/flink-conf.yaml
sed -i -e "s/taskmanager.heap.mb: 1024/taskmanager.heap.mb: ${FLINK_TASKMANAGER_HEAP_MB}/g" /usr/local/flink/conf/flink-conf.yaml
sed -i -e "s/taskmanager.numberOfTaskSlots: 1/taskmanager.numberOfTaskSlots: ${FLINK_NUMBER_OF_TASK_SLOTS}/g" /usr/local/flink/conf/flink-conf.yaml
echo "taskmanager.network.memory.fraction: ${FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION}" >> /usr/local/flink/conf/flink-conf.yaml
echo "taskmanager.network.memory.min: ${FLINK_TASKMANAGER_NETWORK_MEMORY_MIN}" >> /usr/local/flink/conf/flink-conf.yaml
echo "taskmanager.network.memory.max: ${FLINK_TASKMANAGER_NETWORK_MEMORY_MAX}" >> /usr/local/flink/conf/flink-conf.yaml
echo "taskmanager.network.numberOfBuffers: ${FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS}" >> /usr/local/flink/conf/flink-conf.yaml
echo "taskmanager.memory.size: ${FLINK_TASKMANAGER_MEMORY_SIZE}" >> /usr/local/flink/conf/flink-conf.yaml
echo "taskmanager.memory.fraction: ${FLINK_TASKMANAGER_MEMORY_FRACTION}" >> /usr/local/flink/conf/flink-conf.yaml
echo "env.java.opts: ${FLINK_JAVA_OPTS}" >> /usr/local/flink/conf/flink-conf.yaml

#sed -i -e "s/taskmanager.hostname:
#sed -i -e "s/taskmanager.rpc.port:
#sed -i -e "s/taskmanager.data.port:
#sed -i -e "s/taskmanager.data.ssl.enabled:
#sed -i -e "s/taskmanager.tmp.dirs:
#sed -i -e "s/taskmanager.debug.memory.startLogThread:
#sed -i -e "s/taskmanager.debug.memory.logIntervalMs:
#sed -i -e "s/taskmanager.maxRegistrationDuration:
#sed -i -e "s/taskmanager.initial-registration-pause:
#sed -i -e "s/taskmanager.max-registration-pause:
#sed -i -e "s/taskmanager.refused-registration-pause:
#sed -i -e "s/taskmanager.jvm-exit-on-oom:
#sed -i -e "s/blob.fetch.retries:
#sed -i -e "s/blob.fetch.num-concurrent:
#sed -i -e "s/blob.fetch.backlog:
#sed -i -e "s/task.cancellation-interval:
#sed -i -e "s/taskmanager.exit-on-fatal-akka-error:
#sed -i -e "s/jobmanager.tdd.offload.minsize:

/usr/local/flink/bin/jobmanager.sh start cluster #local #cluster
echo "Cluster started."

echo "Config file: " && grep '^[^\n#]' /usr/local/flink/conf/flink-conf.yaml
echo "Sleeping 10 seconds, then start to tail the log file"
sleep 10 && tail -f `ls /usr/local/flink/log/*.log | head -n1`

