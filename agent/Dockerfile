# puppet-agent
#
# VERSION               0.0.2

FROM     ubuntu:trusty
MAINTAINER alexrygalov "alexander.rygalov@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV RELEASE=trusty

# set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

ENV PATH=/opt/puppetlabs/bin:$PATH

# update packages
RUN apt-get update \
    && apt-get install -y curl \
    && curl -O http://apt.puppetlabs.com/puppetlabs-release-pc1-${RELEASE}.deb \
    && dpkg -i puppetlabs-release-pc1-${RELEASE}.deb \
    && rm -rf /var/lib/apt/lists/*

# install SSH server and puppet-agent
RUN apt-get update \
    && apt-get install -y openssh-server puppet-agent \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

# set SSH root passwd
RUN echo 'root:root' |chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# run SSH as daemon
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

ADD ./run.sh /root/
RUN chmod +x /root/run.sh
CMD ["/bin/bash", "/root/run.sh"]
