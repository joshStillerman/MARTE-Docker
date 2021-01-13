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
To run the measurement tree, after building and running the container:
```
root@8cdee780f18b:/# mdstcl
TCL> set current monitor 1
TCL>
TCL>
TCL>
TCL> set current monitor /inc
TCL> set tree monitor
TCL> create pulse 0
TCL> set tree monitor /shot=0
TCL> do /meth marte startMarte
```
Connect another terminal and Fire up jScope to look at the data in the background:
```
jScope -def jscope/configurations/monitor.jscp &

```
Then to test it (in the docker)
```
cd 
./test_monitor.py
```
Then to look at the data hit refresh on the jScope (updates every 10 seconds)

Additional examples included:
lev1, sim1, two_parts.jscp  
- create 3 terminals
- in one terminal fire up jScope
```
jScope jscope/configurations/two_parts.jscp &
```
- start the simulator
```
TCL> set tree sim1
TCL> set current sim1 1
TCL> create pulse 0
TCL> set tree sim1 /shot=0
TCL> do /meth marte startMarte
```
- in a second terminal start the controller
```
TCL> set tree lev1
TCL> set current lev1 1
TCL> create pulse 0
TCL> set tree lev1 /shot=0
TCL> do /meth marte startMarte
```
- in the third terminal start sending zeros to the setpoin
```
cd
./send_zero.py
```
- let it run for a bit
- put 0 in the shot box of the jScope
- hit refresh
- type ^c
```
./send_one.py
```
- let it run for a bit
- hit refresh on the scope
- type ^c to stop

To do:
- clean up Dockerfile
  - environment persist across commands

Link to Gabriele's directions
- [Gabriele's MDSplus/MARTe2/Simulink directions](https://docs.google.com/document/d/13b86ljBcJ2ATIZ_8E59QlUWo5uQQYwcs_pPLIFDksjk/edit)
  - They do not include the new MARTE2_SIMULINK_GENERIC device
  - They do not include discussion of simlink atomicity of subsystems
- [Simulink Coder Directions](https://docs.google.com/open?id=1vHRwQuGrafutjCxFYD_RZrZiRauSiPvKrBcOKwYZFno&authuser=jas%40psfc.mit.edu&usp=drive_fs)
  - They do not include description of params.m  that sets model parameters
