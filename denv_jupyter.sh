
use_nvidia=""
if [ "$*" == --no_gpu ]; then
	echo "Not using GPU"
else
	nvidia-smi > /dev/null
	if [ $? -eq 0 ]; then
		use_nvidia='--gpus all'
		echo "Using NVIDIA runtime"
	else
		echo "NVIDIA not found"
	fi
fi

if [ "$1" != "--port" ]; then
	port=8888
	tensorboard=6006
else
	port=$2
	tensorboard=`echo 6006 + $port - 8888 | bc`
fi


#echo Binding Jupyter to port $port and Tensorboard to port $tensorboard
docker run  $use_nvidia --rm -d -u $(id -u):$(id -g) -v $(pwd)/data:/root/data -v $(pwd):/root -v $(pwd)/models/:/root/models -v $(pwd)/saved_models/:/root/saved_models --network host -e "HOST_HOSTNAME=$(hostname)" --name=ai_jupyter ai:latest jupyter notebook --ip="*" --NotebookApp.token='' --NotebookApp.password=''
#docker run  --rm -d -u $(id -u):$(id -g) -v $(pwd)/data:/root/data -v $(pwd):/root -v $(pwd)/models/:/root/models -v $(pwd)/saved_models/:/root/saved_models -p $tensorboard:6006 -p $port:8888 -e "HOST_HOSTNAME=$(hostname)" role_norm:latest jupyter notebook --ip="*" --NotebookApp.token='' --NotebookApp.password=''
#docker run $use_nvidia --rm -d -u $(id -u):$(id -g) -v $(pwd)/data:/root/data -v $(pwd):/root -v $(pwd)/models/:/root/models -v $(pwd)/saved_models/:/root/saved_models -p $tensorboard:6006 -p $port:8888 -e "HOST_HOSTNAME=$(hostname)" role_norm:latest jupyter notebook --ip="*" --NotebookApp.token='' --NotebookApp.password=''
