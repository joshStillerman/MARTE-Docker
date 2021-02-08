from ubuntu:18.04

RUN apt-get update;\
    apt-get -y upgrade
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN   apt-get install -y\
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
      libncursesw5-dev\
      libgtest-dev\
      cmake\
      curl\
      vim\
      flex\
      bison\
      gperf\
      gnupg\
      xinetd



RUN apt-get -y install curl gnupg && curl -fsSL http://www.mdsplus.org/dist/mdsplus.gpg.key | apt-key add -

RUN sh -c "echo 'deb [arch=amd64] http://www.mdsplus.org/dist/Ubuntu18/repo MDSplus alpha' > /etc/apt/sources.list.d/mdsplus.list"      # 18, alpha release

RUN apt-get update
RUN apt-get -y install mdsplus-alpha mdsplus-alpha-devel mdsplus-alpha-rfxdevices

RUN pip install --upgrade setuptools nose tap tap.py;

RUN mkdir -p /opt/MARTe2
ADD MARTe2.tgz /opt/MARTe2/
ADD MARTe2-components.tgz /opt/MARTe2/

 
RUN export MDSPLUS_DIR=/usr/local/mdsplus;export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2; make -f Makefile.linux

RUN export MDSPLUS_DIR=/usr/local/mdsplus;export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-components;make -f Makefile.linux

RUN echo "no"
RUN cd /opt/MARTe2; git clone https://github.com/MDSplus/MARTe2-MDSplus.git; cd MARTe2-MDSplus; git checkout develop

RUN export MDSPLUS_DIR=/usr/local/mdsplus;export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe3/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/Components/MDSEventManager;make -f Makefile.linux
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/GAMs/MathExpressionGAM;make -f Makefile.linux

RUN apt-get -y remove python3-numpy; \
rm /usr/bin/python3; \
ln -s /usr/bin/python3.7 /usr/bin/python3; \
pip3 install numpy; \
pip3 install matplotlib

ADD ub-python3.patch /opt/MARTe2/MARTe2-MDSplus/
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/; patch -i ub-python3.patch GAMs/PyGAM/Makefile.inc 
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/GAMs/PyGAM;make -f Makefile.linux

RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/Startup; make -f Makefile.linux

RUN mkdir -p /usr/local/mdsplus/local
ADD envsyms /usr/local/mdsplus/local

RUN cd /usr/local/mdsplus/python/MDSplus/; python setup.py install; python3 setup.py install

RUN echo ". /etc/profile.d/mdsplus.sh" >> ~/.bashrc

ADD receive_evstream /root/receive_evstream
ADD receive_evstream.cpp /root/receive_evstream.cpp

RUN export MDSPLUS_DIR=/usr/local/mdsplus; export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/DataSources/MDSReaderNS/; make -f Makefile.linux

RUN  export MDSPLUS_DIR=/usr/local/mdsplus; export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/DataSources/StreamOut/; make -f Makefile.linux

RUN  export MDSPLUS_DIR=/usr/local/mdsplus; export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/DataSources/StreamIn/; make -f Makefile.linux

RUN  export MDSPLUS_DIR=/usr/local/mdsplus; export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/DataSources/SWTrig/; make -f Makefile.linux

#patch Playground.sh so it is x86 not ARM
#ADD Playground.patch /opt/MARTe2/MARTe2-MDSplus/
#RUN cd /opt/MARTe2/MARTe2-MDSplus/; patch -i Playground.patch Startup/Playground.sh

ADD scripts.tgz /root/

ADD shared_images.tgz /usr/local/mdsplus/lib/
ADD MARTE2_COMPONENT.py /usr/local/pydevices/RfxDevices/

ADD scopes.tgz /root/jscope/configurations/
 
ADD trees.tgz /opt/MARTe2/MARTe2-MDSplus/trees/
#
# remove problematic .py in RfxDevices
#
RUN rm -f /usr/local/mdsplus/pydevices/RfxDevices/__init__.py*
#
ADD models.tgz /root/
