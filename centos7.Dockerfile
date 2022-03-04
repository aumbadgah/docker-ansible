FROM centos:7

RUN yum -y update \
    && yum -y upgrade \
    && yum install -y \
    epel-release \
    centos-release-scl \
    && yum install -y \
    ansible \
    openssh-clients \
    openssh-server \
    sshpass \
    rh-python36 \
    unzip \
    vim \
    && yum autoremove -y

SHELL ["/bin/bash", "-c"]

ENV LANG en_US.utf8
ENV LC_ALL en_US.utf8

RUN source scl_source enable rh-python36 \
    && adduser --create-home ansible \
    && echo "cd ~" >> /home/ansible/.bashrc \
    && echo "source scl_source enable rh-python36" >> /home/ansible/.bashrc \
    && su ansible -c 'source /home/ansible/.bashrc \
    && python3 -m pip install --user --upgrade pip \
    && python3 -m pip install --user ansible boto boto3 botocore'

RUN echo $' \n\
    [defaults] \n\
    host_key_checking = False ' >> /home/ansible/.ansible.cfg

USER ansible

VOLUME [ "/app" ]

WORKDIR /app
ENTRYPOINT [ "bash" ]
