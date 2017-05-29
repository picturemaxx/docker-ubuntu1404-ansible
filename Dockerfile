FROM ubuntu:14.04
MAINTAINER Tobias Kramheller

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       software-properties-common \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Install Ansible and python-pip.
RUN apt-add-repository -y ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       ansible python-pip\
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Install Ansible-Lint
RUN pip install ansible-lint

#Install testinfra
RUN pip install testinfra

# Install Ansible inventory file
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Workaround for pleaserun tool that Logstash uses
RUN rm -rf /sbin/initctl && ln -s /sbin/initctl.distrib /sbin/initctl
