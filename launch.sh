#!/bin/bash
# make sure the file is Executable 
#  check if file is executeable or not
# ls -l launch.sh   
#  -rw-rw-r-- 1 shreeram shreeram 339  9月  2 14:26 launch.sh  (not executeable)
# chmod +x your-script.sh
# ls -l launch.sh 
# -rwxrwxr-x 1 shreeram shreeram 480  9月  2 14:30 launch.sh (now read write and executable is okay)

# run you script ./your-script.sh
# Check if the 5000 port is currently in use or not
# sudo netstat -tuln | grep 5000


# got error docker-compose: 1 : Not found
# solution 
# sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose


docker-compose build # --no-cache # if any trouble some, enable --no-cache
docker-compose up -d
docker-compose exec yolov8_test_docker /bin/bash