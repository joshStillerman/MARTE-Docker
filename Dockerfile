from ubuntu:18.04

RUN apt-get update;\
    apt-get -y upgrade;\
    apt-get install -y\
      rsync reprepro wget git automake make tar\
      g++ gfortran openjdk-8-jdk\
      python-dev python-setuptools python-numpy python-pip\
      libpython3.7 \
      libpython3.7-dev \
      libpython3.7-stdlib \
      python3.7 \
      python3.7-dev \
      python3-dev python3-setuptools python3-numpy python3-pip\
      openssh-server\
      gdb gdbserver\
      libasan0 libtsan0 valgrind\
      libtest-harness-perl\
      libcurl4-gnutls-dev libreadline-dev\
      libdc1394-22-dev libraw1394-dev\
      libxml2-dev freetds-dev\
      libmotif-dev libxt-dev x11proto-print-dev\
      libglobus-xio-gsi-driver-dev\
      libncurses5-dev\
      libncursesw5-dev;
RUN apt-get -y install libgtest-dev cmake

RUN pip install --upgrade setuptools nose tap tap.py;
RUN git config --global http.sslVerify false
ARG SSH_KEY
ENV SSH_KEY=$SSH_KEY

# Make ssh dir
RUN mkdir /root/.ssh/
 
# Create id_rsa from string arg, and set permissions

RUN echo "$SSH_KEY" > /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
 
# Create known_hosts
RUN touch /root/.ssh/known_hosts

RUN ssh-keyscan github.mit.edu >> /root/.ssh/known_hosts
RUN mkdir -p /opt/MARTe2; cd /opt/MARTe2; git clone git@github.mit.edu:jas/MARTe2.git; cd MARTe2;git checkout develop

RUN cd /opt/MARTe2; git clone git@github.mit.edu:jas/MARTe2-components.git; cd MARTe2-components; git checkout develop

RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2; make -f Makefile.linux;cd /opt/MARTe2/MARTe2-components;make -f Makefile.linux

RUN apt-get -y install curl gnupg && curl -fsSL http://www.mdsplus.org/dist/mdsplus.gpg.key | apt-key add -

RUN sh -c "echo 'deb [arch=amd64] http://www.mdsplus.org/dist/Ubuntu18/repo MDSplus alpha' > /etc/apt/sources.list.d/mdsplus.list"	# 18, alpha release

RUN apt-get update

RUN apt-get -y install mdsplus-alpha mdsplus-alpha-devel

RUN cd /opt/MARTe2; git clone https://github.com/MDSplus/MARTe2-MDSplus.git
RUN export MDSPLUS_DIR=/usr/local/mdsplus;export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/Components/MDSEventManager;make -f Makefile.linux
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/GAMs/MathExpressionGAM;make -f Makefile.linux
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/GAMs/SimulinkInterfaceGAM; make -f Makefile.linux

# make sure python3.7 is the default python3 and numpy is installed
RUN apt-get -y remove python3-numpy; \
rm /usr/bin/python3; \
ln -s /usr/bin/python3.7 /usr/bin/python3; \
pip3 install numpy

RUN apt-get -y install vim 

#patch pygam to match UB python locations
ADD ub-python3.patch /opt/MARTe2/MARTe2-MDSplus/
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/; patch -i ub-python3.patch GAMs/PyGAM/Makefile.inc 
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/GAMs/PyGAM;make -f Makefile.linux

RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/Startup; make -f Makefile.linux

RUN mkdir -p /usr/local/mdsplus/local
ADD envsyms /usr/local/mdsplus/local

RUN apt-get -y install mdsplus-alpha-rfxdevices

RUN cd /usr/local/mdsplus/python/MDSplus/; python setup.py install; python3 setup.py install

RUN echo ". /etc/profile.d/mdsplus.sh" >> ~/.bashrc

ADD lev_model.tree /opt/MARTe2/MARTe2-MDSplus/trees/lev_model.tree
ADD lev_model.characteristics /opt/MARTe2/MARTe2-MDSplus/trees/lev_model.characteristics
ADD lev_model.datafile /opt/MARTe2/MARTe2-MDSplus/trees/lev_model.datafile

ADD receive_evstream /root/receive_evstream
ADD receive_evstream.cpp /root/receive_evstream.cpp

RUN export MDSPLUS_DIR=/usr/local/mdsplus; export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/DataSources/MDSReaderNS/; make -f Makefile.linux

RUN  export MDSPLUS_DIR=/usr/local/mdsplus; export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/DataSources/StreamOut/; make -f Makefile.linux

RUN  export MDSPLUS_DIR=/usr/local/mdsplus; export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/DataSources/StreamIn/; make -f Makefile.linux

RUN  export MDSPLUS_DIR=/usr/local/mdsplus; export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/DataSources/SWTrig/; make -f Makefile.linux
