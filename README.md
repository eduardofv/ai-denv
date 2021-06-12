# ai_denv: a development environment for AI / ML / Tensorflow / Pytorch projects 

## Goal

Have a containerized development environment for projects that use some of the most common libraries and utilities for AI, ML, etc. This makes possible to have an independent and upgradable environment that can be shared between projects or server.

This is an initial point that may be adapted to specific needs. Check the `Dockerfile` to see what will be installed. Installs GPU support for most libraries as it's based on GPU enabled Tensorflow image. Packages for R are commented but you can uncomment them.


## Usage

- Build the docker image `docker build -t ai:latest .`
- Create or move to you project directory. You may want to create any directory used by the container. It will create them but will be owned by root.
- Run the environment:
	- Use `./denv.sh` to run a shell in the environment
	- Use `./denv_jupyter.sh` to run a jupyter notebook server within the environment

## Considerations

- If using a GPU, check requirements for [Tensorflow docker GPU enabled images](https://www.tensorflow.org/install/docker#gpu_support)
- New software installed in the container will be lost as it runs as a *ephemeral container*. If you install something you plan to use all the time in your project add it to `Dockerfile` and rebuild.

- It opens default ports for Jupyter, Tensorboard and Flask
