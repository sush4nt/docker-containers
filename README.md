# DSML
A simple framework for basic Data Science applications 

## Guide


### Steps:
1.  Create a dedicated folder for installation
2.  Install Docker Desktop for Windows
3.  Open Powershell; run as Administrator
4.  Change the directory to the dedicated folder
5.  Verify if the command `docker` is working on Powershell window
6.  Build the Docker Container using the following command:

            docker build -t image_name path/to/Dockerfile/folder
7.  Build the container using the image built:

           docker run -it `
           -v ${PWD}:/workspace/ `
           -p 8888:8888 -p 6006:6006 `
           --name container_name image_name `
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


### References:

1. https://pythonhosted.org/an_example_pypi_project/setuptools.html
2. https://docs.docker.com/
3. https://tmuxguide.readthedocs.io/en/latest/tmux/tmux.html
4. https://linuxize.com/post/getting-started-with-tmux/
5. https://www.hostinger.in/tutorials/tmux-beginners-guide-and-cheat-sheet/

### Additional References

1. To add jupyter notebook extensions:

   a. `pip install jupyter_contrib_nbextensions`
  
   b. `jupyter contrib nbextension install --user`
2. Useful packages:

            nb_black
            mlxtend
            xgboost
            lightgbm
            missingno
3. For installing PySpark:
            [refer this article](https://medium.com/@patilvijay23/installing-and-using-pyspark-on-linux-machine-e9f8dddc0c9a)
