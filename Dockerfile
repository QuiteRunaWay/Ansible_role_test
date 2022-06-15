FROM centos:centos7.9.2009
ENV MOLECULE_NO_LOG false

RUN yum makecache fast
RUN yum -y install glibc-common
RUN export PATH=$PATH:/usr/local/bin
RUN yum update -y && yum install tar gcc make python3-pip zlib-devel openssl-devel yum-utils libffi-devel -y
ADD https://www.python.org/ftp/python/3.7.10/Python-3.7.10.tgz Python-3.7.10.tgz
RUN tar xf Python-3.7.10.tgz && cd Python-3.7.10/ && ./configure && make && make altinstall
ADD https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz Python-3.9.2.tgz
RUN tar xf Python-3.9.2.tgz && cd Python-3.9.2/ && ./configure && make && make altinstall
RUN python3 -m pip install --upgrade pip && pip3 install tox selinux
RUN rm -rf Python-*