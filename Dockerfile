FROM ubuntu:20.04

COPY ./files/ /tmp/files

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.aliyun.com/g" /etc/apt/sources.list && \
    sed -i '/security/d' /etc/apt/sources.list && \
    apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y lib32z1 openssh-server libstdc++6 lib32stdc++6 && \
    echo 'ctf - nproc 1500' >>/etc/security/limits.conf && \
    useradd -U -m ctf && \
    echo 'ctf:guest' | chpasswd  && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    mkdir /var/run/sshd && \
    mv /tmp/files/pwn /home/ctf/pwn && \
    mv /tmp/files/start.sh / && \
    mv /tmp/files/flag.sh / && \
    rm -rf /tmp/* /var/tmp/*

WORKDIR /home/ctf

CMD /start.sh

EXPOSE 22
