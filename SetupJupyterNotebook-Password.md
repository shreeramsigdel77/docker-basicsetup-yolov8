# Pre-requirements:

Installation of docker and establishment of a container

Make sure the port not being used

# Setting up Password for Jupyter notebook

1. Start your docker container and exec to terminal. Here docker_test-yolov8_test_docker-1 is container name

```
docker exec -it docker_test-yolov8_test_docker-1 /bin/bash
```

2. Generate Sha1 password with ipython. In terminal

```
ipython
from IPython.lib import passwd 
passwd()
```

3. Enter Password and copy Sha1:  (You need both entered password to login into jupyter notebook and Sha1 to setup password)
   copy 'sha1:XXXXXXXX'      (In ubuntu you can use ctrl+ shift +C to copy the terminal)
4. exit
5. Within the container setup jupyter_notebook_config

   ```
   jupyter-lab --generate-config
   ```
6. Add the following configurations:
   nano /root/.jupyter/jupyter_notebook_config.py

   nano basic guide
   Ctrl + W (search)
   Ctrl + 0 (save )- ubuntu
   Ctrl + X (exit)

   Add the following line in config file

```
c.NotebookApp.allow_remote_access = True
c.NotebookApp.ip = 'localhost'
c.NotebookApp.open_browser = False
c.NotebookApp.password = 'sha1:XXXXXXXXXXXXX'
c.NotebookApp.port = 5000
```

7. Save and Exit
8. Stop Docker Container and Rebuild (note docker_test-yolov8_test_docker-1 is docker container name)

   ```
   docker stop docker_test-yolov8_test_docker-1

   ```

   ```
   sh launch.sh
   ```
9. Access jupyter notebook on local machine with port forwarding

   ssh -L 5000:localhost:5000 username@vpn-server-ip

   e.g ssh -L 5000:localhost:5000 shree-gpu@172.16.XX.XX
10. Open webbrowser and hit the url (make sure to use appropriate port) and enter password to login

```
http://localhost:5000/
```

10. Now you can check with another remote PC as well. You should be able to login and use jupyter notebook

    ```
    http://hostmachine_ip:5000/
    ```

Additional

check if docker is running or not

docker ps

if not

docker run -d -p 5000:5000 <image_name>

or simpley sh launch.sh

2. Verify server's IP  and port accessibility
3.
