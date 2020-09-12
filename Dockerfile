from ubuntu:18.04

RUN apt-get update;\
    apt-get -y upgrade;\
    apt-get install -y\
      rsync reprepro wget git automake make tar\
      g++ gfortran openjdk-8-jdk\
      python-dev python-setuptools python-numpy python-pip\
      openssh-server\
      gdb gdbserver\
      libasan0 libtsan0 valgrind\
      libtest-harness-perl\
      libcurl4-gnutls-dev libreadline-dev\
      libdc1394-22-dev libraw1394-dev\
      libxml2-dev freetds-dev\
      libmotif-dev libxt-dev x11proto-print-dev\
      libglobus-callout-dev\
      libglobus-gridmap-callout-error-dev\
      libglobus-gsi-credential-dev\
      libglobus-gsi-proxy-core-dev\
      libglobus-gss-assist-dev\
      libglobus-gssapi-gsi-dev\
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
RUN apt-get install -y python3-numpy libpython3-dev python3-dev
