#!/bin/bash


if [[ ${@: -1} == "up" ]];then
	UPDOWN="up"

	FLINK_JOBMANAGER_RPC_PORT="FLINK_JOBMANAGER_RPC_PORT=6123"
	FLINK_JOBMANAGER_HEAP_MB="FLINK_JOBMANAGER_HEAP_MB=1024"
	FLINK_TASKMANAGER_HEAP_MB="FLINK_TASKMANAGER_HEAP_MB=1024"
	FLINK_NUMBER_OF_TASK_SLOTS="FLINK_NUMBER_OF_TASK_SLOTS=1"
	FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION="FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION=0.1"
	FLINK_TASKMANAGER_NETWORK_MEMORY_MIN="FLINK_TASKMANAGER_NETWORK_MEMORY_MIN=64000000"
	FLINK_TASKMANAGER_NETWORK_MEMORY_MAX="FLINK_TASKMANAGER_NETWORK_MEMORY_MAX=1000000000"
	FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS="FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS=2048"
	FLINK_TASKMANAGER_MEMORY_SIZE="FLINK_TASKMANAGER_MEMORY_SIZE=-1"
	FLINK_TASKMANAGER_MEMORY_FRACTION="FLINK_TASKMANAGER_MEMORY_FRACTION=0.7"
	FLINK_JAVA_OPTS=""
	set -- "${@:1:$(($#-1))}"
	while test $# -gt 0; do
		case "$1" in
			-h|--help)
				echo "Usage: deploy.sh [OPTIONS] up|down"
				echo "--jmport		set jobmanager rpc port"
				echo "--jmheap		set jobmanager heap in mb"
				echo "--tmheap		set taskmanager heap in mb"
				echo "--slots		set number of task slots"
				echo "--netfraction	set fraction of taskmanager memory for networking"
				echo "--netmin		set minimum memory size for network buffer in bytes"
				echo "--netmax		set maximum memory size for network buffer in bytes"
				echo "--netbuffers	set number of network buffers (deprecated)"
				echo "--tmmemsize	set taskmanager memory size"
				echo "--tmmemfraction	set relative amount of taskmanager memory for internal data buffers"
				echo "--javaopts	set custom JVM options"
				exit 0
				;;
			--jmport)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_JOBMANAGER_RPC_PORT="FLINK_JOBMANAGER_RPC_PORT=$1"
					echo "$FLINK_JOBMANAGER_RPC_PORT"
				else
					echo "No jobmanager RPC port supplied"
					exit 1
				fi
				shift
				;;
			--jmheap)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_JOBMANAGER_HEAP_MB="FLINK_JOBMANAGER_HEAP_MB=$1"
					echo "$FLINK_JOBMANAGER_HEAP_MB"
				else
					echo "No jobmanager heap size supplied"
					exit 1
				fi
				shift
				;;
			--tmheap)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_TASKMANAGER_HEAP_MB="FLINK_TASKMANAGER_HEAP_MB=$1"
					echo "$FLINK_TASKMANAGER_HEAP_MB"
				else
					echo "No taskmanager heap size supplied"
					exit 1
				fi
				shift
				;;
			--slots)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_NUMBER_OF_TASK_SLOTS="FLINK_NUMBER_OF_TASK_SLOTS=$1"
					echo "$FLINK_NUMBER_OF_TASK_SLOTS"
				else
					echo "No number of task slots supplied"
					exit 1
				fi
				shift
				;;
			--netfraction)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION="FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION=$1"
					echo "$FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION"
				else
					echo "No taskmanager network memory fraction supplied"
					exit 1
				fi
				shift
				;;
			--netmin)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_TASKMANAGER_NETWORK_MEMORY_MIN="FLINK_TASKMANAGER_NETWORK_MEMORY_MIN=$1"
					echo "$FLINK_TASKMANAGER_NETWORK_MEMORY_MIN"
				else
					echo "No taskmanager network memory min supplied"
					exit 1
				fi
				shift
				;;
			--netmax)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_TASKMANAGER_NETWORK_MEMORY_MAX="FLINK_TASKMANAGER_NETWORK_MEMORY_MAX=$1"
					echo "$FLINK_TASKMANAGER_NETWORK_MEMORY_MAX"
				else
					echo "No taskmanager network memory max supplied"
					exit 1
				fi
				shift
				;;
			--netbuffers)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS="FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS=$1"
					echo "$FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS"
				else
					echo "No taskmanager network number of buffers supplied"
					exit 1
				fi
				shift
				;;
			--tmmemsize)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_TASKMANAGER_MEMORY_SIZE="FLINK_TASKMANAGER_MEMORY_SIZE=$1"
					echo "$FLINK_TASKMANAGER_MEMORY_SIZE"
				else
					echo "No taskmanager memory size supplied"
					exit 1
				fi
				shift
				;;
			--tmmemfraction)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_TASKMANAGER_MEMORY_FRACTION="FLINK_TASKMANAGER_MEMORY_FRACTION=$1"
					echo "$FLINK_TASKMANAGER_MEMORY_FRACTION"
				else
					echo "No taskmanager memory fraction supplied"
					exit 1
				fi
				shift
				;;
			--javaopts)
				shift
				if test $# -gt 0 && [[ $1 != --* ]]; then
					FLINK_JAVA_OPTS="FLINK_JAVA_OPTS=$1"
					echo "$FLINK_JAVA_OPTS"
				else
					echo "No JVM options supplied"
					exit 1
				fi
				shift
				;;
			*)
				break
				;;
		esac
	done
elif [[ ${@: -1} == "down" ]];then
	UPDOWN="down"
else
	echo "Usage: deploy.sh [OPTIONS] up|down"
	echo "--jmport		set jobmanager rpc port"
	echo "--jmheap		set jobmanager heap in mb"
	echo "--tmheap		set taskmanager heap in mb"
	echo "--slots		set number of task slots"
	echo "--netfraction	set fraction of taskmanager memory for networking"
	echo "--netmin		set minimum memory size for network buffer in bytes"
	echo "--netmax		set maximum memory size for network buffer in bytes"
	echo "--netbuffers	set number of network buffers (deprecated)"
	echo "--tmmemsize	set taskmanager memory size"
	echo "--tmmemfraction	set relative amount of taskmanager memory for internal data buffers"
	echo "--javaopts	set custom JVM options"
	exit 0
fi

if [[ $UPDOWN = "up" ]];then
	echo "Starting master node"
	docker service create --name flink-master --network flink --replicas 1 --constraint 'node.hostname == akswnc4.aksw.uni-leipzig.de' --restart-condition on-failure --endpoint-mode dnsrr \
	-e ENABLE_INIT_DAEMON=false \
	-e $FLINK_JOBMANAGER_RPC_PORT \
	-e $FLINK_JOBMANAGER_HEAP_MB \
	-e $FLINK_TASKMANAGER_HEAP_MB \
	-e $FLINK_NUMBER_OF_TASK_SLOTS \
	-e $FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION \
	-e $FLINK_TASKMANAGER_NETWORK_MEMORY_MIN \
	-e $FLINK_TASKMANAGER_NETWORK_MEMORY_MAX \
	-e $FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS \
	-e $FLINK_TASKMANAGER_MEMORY_SIZE \
	-e $FLINK_TASKMANAGER_MEMORY_FRACTION \
	-e $FLINK_JAVA_OPTS \
	-d docker-swarm-flink-master && \
	echo "Starting worker node" && \
	docker service create --name flink-worker --network flink --mode global --restart-condition on-failure --endpoint-mode dnsrr -e ENABLE_INIT_DAEMON=false \
	 -e FLINK_MASTER_PORT_6123_TCP_ADDR=flink-master \
	-e $FLINK_JOBMANAGER_RPC_PORT \
	-e $FLINK_JOBMANAGER_HEAP_MB \
	-e $FLINK_TASKMANAGER_HEAP_MB \
	-e $FLINK_NUMBER_OF_TASK_SLOTS \
	-e $FLINK_TASKMANAGER_NETWORK_MEMORY_FRACTION \
	-e $FLINK_TASKMANAGER_NETWORK_MEMORY_MIN \
	-e $FLINK_TASKMANAGER_NETWORK_MEMORY_MAX \
	-e $FLINK_TASKMANAGER_NETWORK_NUMBER_OF_BUFFERS \
	-e $FLINK_TASKMANAGER_MEMORY_SIZE \
	-e $FLINK_TASKMANAGER_MEMORY_FRACTION \
	-e $FLINK_JAVA_OPTS \
	-d docker-swarm-flink-worker && \
	echo "Copying files" && \
	/bin/bash copyfiles.sh limes-core-1.2.0-SNAPSHOT.jar / && \
	/bin/bash copyfiles.sh mocking.ttl / 

elif [[ $1 = "down" ]];then
	docker service rm flink-master
	docker service rm flink-worker
fi
