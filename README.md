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

To do:
- switch python3 from 3.6.9 to 3.7m
  - work out numpy
- make a branch of MARTE-MDSplus with the right defaults for python interpreter location
- use that branch instead
- clean up Dockerfile
  - some extra stuff (globus)
  - installs all at top
  - environment persist across commands
  - separate RUN commands are good because then things can be changed without redoing everything

