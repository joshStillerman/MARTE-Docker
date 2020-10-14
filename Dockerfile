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
      libncursesw5-dev\
      libgtest-dev\
      cmake\
      curl\
      vim\
      flex\
      bison\
      gperf\
      gnupg\
      xinetd;


RUN apt-get -y install curl gnupg && curl -fsSL http://www.mdsplus.org/dist/mdsplus.gpg.key | apt-key add -

RUN sh -c "echo 'deb [arch=amd64] http://www.mdsplus.org/dist/Ubuntu18/repo MDSplus alpha' > /etc/apt/sources.list.d/mdsplus.list"      # 18, alpha release

#RUN apt-get update

ADD mdsplus-alpha-camac_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-camac_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-d3d_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-devel_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-devel_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-epics_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-gsi_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-gsi_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-hdf5_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-hdf5_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-htsdevices_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-idl_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-idl_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-java_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-java_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-kbsidevices_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-kernel_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-kernel_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-labview_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-labview_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-matlab_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-mitdevices_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-mitdevices_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-motif_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-motif_bin_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-mssql_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-php_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-python_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-repo_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-rfxdevices_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha-w7xdevices_7.113.3_amd64.deb /var/cache/apt/archives/
ADD mdsplus-alpha_7.113.3_amd64.deb /var/cache/apt/archives/

RUN apt-get update
RUN apt-get -y install mdsplus-alpha mdsplus-alpha-devel mdsplus-alpha-rfxdevices

RUN pip install --upgrade setuptools nose tap tap.py;

#make mdsplus from branch gm_devices
#RUN cd;git clone --depth=1 https://github.com/MDSplus/mdsplus.git;cd mdsplus;./bootstrap;mkdir -p ../build; cd ../build; ../mdsplus/configure --prefix=/usr/local/mdsplus; make; make install

RUN echo "space"
RUN mkdir -p /opt/MARTe2
ADD MARTe2.tgz /opt/MARTe2/
ADD MARTe2-components.tgz /opt/MARTe2/

#RUN mkdir -p /opt/MARTe2; cd /opt/MARTe2; git clone https://github.com/aneto0/MARTe2; cd MARTe2;git checkout develop

#RUN cd /opt/MARTe2; git clone https://github.com/aneto0/MARTe2-components; cd MARTe2-components; git checkout develop

#RUN ln -s /usr/local/mdsplus/lib/ /usr/local/mdsplus/lib64;
 
RUN export MDSPLUS_DIR=/usr/local/mdsplus;export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2; make -f Makefile.linux

RUN export MDSPLUS_DIR=/usr/local/mdsplus;export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-components;make -f Makefile.linux

RUN echo "yes"
RUN cd /opt/MARTe2; git clone https://github.com/MDSplus/MARTe2-MDSplus.git; cd MARTe2-MDSplus; git checkout develop
#RUN cd /opt/MARTe2; git clone https://github.com/MDSplus/MARTe2-MDSplus.git; cd MARTe2-MDSplus; git checkout develop

RUN export MDSPLUS_DIR=/usr/local/mdsplus;export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe3/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/Components/MDSEventManager;make -f Makefile.linux
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/GAMs/MathExpressionGAM;make -f Makefile.linux
#RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/GAMs/SimulinkInterfaceGAM; make -f Makefile.linux

# make sure python3.7 is the default python3 and numpy is installed
RUN apt-get -y remove python3-numpy; \
rm /usr/bin/python3; \
ln -s /usr/bin/python3.7 /usr/bin/python3; \
pip3 install numpy

#patch pygam to match UB python locations
ADD ub-python3.patch /opt/MARTe2/MARTe2-MDSplus/
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/; patch -i ub-python3.patch GAMs/PyGAM/Makefile.inc 
RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/GAMs/PyGAM;make -f Makefile.linux

RUN export MARTe2_DIR=/opt/MARTe2/MARTe2; export MARTe2_Components_DIR=/opt/MARTe2/MARTe2-components;cd /opt/MARTe2/MARTe2-MDSplus/Startup; make -f Makefile.linux

RUN mkdir -p /usr/local/mdsplus/local
ADD envsyms /usr/local/mdsplus/local

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

#patch Playground.sh so it is x86 not ARM
#ADD Playground.patch /opt/MARTe2/MARTe2-MDSplus/
#RUN cd /opt/MARTe2/MARTe2-MDSplus/; patch -i Playground.patch Startup/Playground.sh

ADD sender.py /root/

ADD libSimulinkWrapperGAM.so /usr/local/mdsplus/lib/
ADD counter.so /usr/local/mdsplus/lib/
ADD increment.so /usr/local/mdsplus/lib/
ADD libSimulinkWrapperGAM.so /usr/local/mdsplus/lib/
ADD Controller.so /usr/local/mdsplus/lib/
ADD Plant.so /usr/local/mdsplus/lib/
ADD SetpointGeneration.so /usr/local/mdsplus/lib/

RUN ln -s /usr/local/mdsplus/lib/libSimulinkWrapperGAM.so /usr/local/mdsplus/lib/SimulinkWrapperGAM.so
ADD rtw_capi_wrapper.so /usr/local/mdsplus/lib/
ADD MARTE2_COMPONENT.py /usr/local/pydevices/RfxDevices/

ADD mag_model.tree /opt/MARTe2/MARTe2-MDSplus/trees/
ADD mag_model.datafile /opt/MARTe2/MARTe2-MDSplus/trees/
ADD mag_model.characteristics /opt/MARTe2/MARTe2-MDSplus/trees/

ADD mag.jscp /root/jscope/configurations/
