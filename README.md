A Docker image to run MARTE with the MDSplus components. 

Pulls MARTe2 and MARTe2-Components from github

Build with:
```
docker build -t marte2 .
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

To use:
- connect 3 terminals to running container
  - in first one: 
```
mdstcl
TCL> set tree mag2
TCL> create pulse 1
TCL> set tree mag2 /shot=1
TCL> do /meth marte startMarte
```
  - in second one
```
cd
./receive_evstream MEASURE
```
  - in third one
```
cd
./sender.py
```
To do:
- clean up Dockerfile
  - environment persist across commands

Link to Gabriele's directions
- [Gabriele's MDSplus/MARTe2/Simulink directions](https://docs.google.com/document/d/13b86ljBcJ2ATIZ_8E59QlUWo5uQQYwcs_pPLIFDksjk/edit)
  - They do not include the new MARTE2_SIMULINK_GENERIC device
  - They do not include discussion of simlink atomicity of subsystems
- [Simulink Coder Directions](https://docs.google.com/open?id=1vHRwQuGrafutjCxFYD_RZrZiRauSiPvKrBcOKwYZFno&authuser=jas%40psfc.mit.edu&usp=drive_fs)
  - They do not include description of params.m  that sets model parameters
