use_nvidia=""

if [ "$*" == --no_gpu ]; then
	echo "Not using GPU"
else
	nvidia-smi > /dev/null
	if [ $? -eq 0 ]; then
		#use this for older version of nvidia docker 
		#use_nvidia='--runtime=nvidia'
		use_nvidia='--gpus=all'
		echo "Using NVIDIA runtime"
	else
		echo "NVIDIA not found"
	fi
fi
	
docker run $use_nvidia --rm -it -u $(id -u):$(id -g) \
	-v $(pwd)/data:/root/data -v $(pwd):/root -v $(pwd)/models/:/root/models -v $(pwd)/saved_models/:/root/saved_models \
	-e "HOST_HOSTNAME=$(hostname)" -p 5000:5000 --name ai_denv \
	ai:latest /bin/bash
