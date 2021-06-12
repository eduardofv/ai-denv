# ai_denv: a development environment for AI / ML / Tensorflow / Pytorch projects 

## Goal

Have a containerized development environment for projects that use some of the most common libraries and utilities for AI, ML, etc. This makes posible to have an independent and upgradable environment that can be shared between projects or server.

This is an initial point that may be adapted to specific needs. Check the `Dockerfile` to see what is installed. Installs GPU support for most libraries as it's based on GPU enabled Tensorflow image. Packages for R are commented but you can uncomment them.

New software installed in the container will be lost as it runs as a *ephimeral container*. If you will use it, add to the `Dockefile` and rebuild.

## Usage

- Build the docker image `docker build -t ai:latest .`
- Create or move to you project directory. You may want to create any directory used by the container. It will create them but will be owned by root.
- Run the enviroment:
	- Use `./denv.sh` to run a shell in the environment
	- Use `./denv_jupyter.sh` to run a jupyter notebook server within the environment


