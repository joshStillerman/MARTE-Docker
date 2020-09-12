A Docker image to run MARTE with the MDSplus components. 

Pulls MARTe2 and MARTe2-Components from github.mit.edu

Requires ssh key for mit's GITHUB

Build with:
```
docker build -t marte2 --build-arg SSH_KEY="$(cat ~/.ssh/id_rsa)" .
```

Run with:
```
docker run -it marte2 /bin/bash
```
