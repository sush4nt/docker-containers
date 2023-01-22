# DSML
A simple skeleton framework for basic Data Science applications 

## Why the need Docker Images?
Docker Official Images are a curated set of Docker open source and drop-in solution repositories. These images have clear documentation, promote best practices, and are designed for the most common use cases.

## Guide


### Steps:
1.  Create a dedicated folder for installation
2.  Install Docker Desktop for Windows/Linux
3.  Open Powershell; run as Administrator/ Open Terminal
4.  Change the directory to the dedicated folder
5.  Verify if the command `docker` is working on Powershell/Terminal window
6.  Build the Docker Container using the following command:

            docker build -t image_name path/to/Dockerfile/folder
7.1  Build the container using the image built(Windows users):

            docker run -it `
            -v ${PWD}:/workspace/ `
            -p 8888:8888 -p 8050:8050 `
            --name container_name image_name `
            /bin/bash
7.2  Build the container using the image built(Linux users):

             docker run -it \
             -v $(pwd):/workspace/ \
             --net=host \
             --name <container_name> \
             <image_name> \
             /bin/bash
8.  Start the container:
            docker start container_name
9.  Attach to the container:
            docker attach container_name
10. Use the alias `work` to start the tmux sessions


### Additional commands:
1.  List downloaded images: `docker image ls`
2.  Check currently running or previously run containers: `docker ps -a`
3.  Start a container: `docker start container_name`
4.  Attach to a container: `docker attach container_name`
5.  Detach from tmux workspace: `ctrl+a`+`d` or `tmux detach` or `exit`
6.  Delete a container: `docker rm container_name`
7.  Delete all containers: `docker rm -f $(docker ps -a -q)`
8.  Reattach to the tmux workspace: `tmux a` or `tmux attach`
9.  Exit a container: `exit`
10. To check docker disk usage: `docker system df`
11. To remove all docker build cache, containers and images: `docker system prune -all`
12. To remove docker build cache: `docker builder prune`


### References:

1. https://pythonhosted.org/an_example_pypi_project/setuptools.html
2. https://docs.docker.com/
3. https://tmuxguide.readthedocs.io/en/latest/tmux/tmux.html
4. https://linuxize.com/post/getting-started-with-tmux/
5. https://www.hostinger.in/tutorials/tmux-beginners-guide-and-cheat-sheet/
6. https://docs.docker.com/desktop/install/ubuntu/
7. https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository

### Additional References

1. Useful packages:

            nb_black
            mlxtend
            xgboost
            lightgbm
            missingno
2. For installing PySpark:
            [refer this article](https://medium.com/@patilvijay23/installing-and-using-pyspark-on-linux-machine-e9f8dddc0c9a)
3. To copy contents on tmux pandes, refer to [issue](https://unix.stackexchange.com/questions/332419/tmux-mouse-mode-on-does-not-allow-to-select-text-with-mouse?noredirect=1&lq=1)
