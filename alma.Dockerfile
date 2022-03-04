FROM almalinux

RUN dnf update -y \
    && dnf upgrade -y \
    && dnf install -y epel-release \
    && dnf install -y \
    ansible \
    openssh-clients \
    # openssh-server \
    sshpass \
    && dnf autoremove -y

SHELL ["/bin/bash", "-c"]

VOLUME [ "/app" ]

WORKDIR /app
ENTRYPOINT [ "bash" ]
