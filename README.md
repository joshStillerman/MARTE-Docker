A Docker image to run MARTE with the MDSplus components. 

Pulls MARTe2 and MARTe2-Components from github.mit.edu

Requires ssh key for mit's GITHUB

Build with:
```
docker build -t marte2 --build-arg SSH_KEY="$(cat ~/.ssh/id_rsa)" .
```

Run once with:
```
docker run -it marte2 /bin/bash
```

Run and leave running:
```
docker run -dt marte2
```

Connect to it with:
```
% docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
bd9a7b15eec1        marte2              "/bin/bash"         12 minutes ago      Up 12 minutes                           infallible_proskuriakova

% docker exec -it bd9a7b15eec1 /bin/bash
```

To do:
- clean up Dockerfile
  - installs all at top
  - environment persist across commands
  - separate RUN commands are good because then things can be changed without redoing everything
- configure lev tree to do something
- make a tree that actually calls simulink
- write directions

Link to Gabriele's directions:
- https://docs.google.com/document/d/13b86ljBcJ2ATIZ_8E59QlUWo5uQQYwcs_pPLIFDksjk/edit
