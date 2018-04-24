# Start the flink task manager (slave)
echo "Configuring Task Manager on this node"
FLINK_MASTER_PORT_6123_TCP_ADDR=`host ${FLINK_MASTER_PORT_6123_TCP_ADDR} | grep "has address" | awk '{print $4}'`

sed -i -e "s/jobmanager.rpc.address: localhost/jobmanager.rpc.address: ${FLINK_MASTER_PORT_6123_TCP_ADDR}/g" /usr/local/flink/conf/flink-conf.yaml

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

echo "Starting Task Manager"
/usr/local/flink/bin/taskmanager.sh start

echo "Config file: " && grep '^[^\n#]' /usr/local/flink/conf/flink-conf.yaml
echo "Sleeping 10 seconds, then start to tail the log file"
sleep 10 && tail -f `ls /usr/local/flink/log/*.log | head -n1`
