FROM python:2.7-slim-jessie

MAINTAINER Surisetty, Naresh "naresh@naresh.co"

COPY oracle.zip /tmp/

# Install Ubuntu packages
RUN apt-get update
RUN apt-get install alien dpkg-dev debhelper build-essential libaio1 --assume-yes

ADD oracle.conf /etc/ld.so.conf.d/oracle.conf
ADD oracle.sh /etc/profile.d/oracle.sh
RUN chmod +x /etc/ld.so.conf.d/oracle.conf
RUN chmod +x /etc/profile.d/oracle.sh

RUN apt-get update -y && \
    apt-get install -y dpkg-dev && \
    apt-get install -y debhelper && \
    apt-get install -y build-essential && \
    apt-get install -y libaio1 && \
    unzip "/tmp/oracle.zip" -d /usr/lib/ && \
    /etc/profile.d/oracle.sh && \
    ldconfig && \
    apt-get -s clean all

ADD requirements.txt /code/
WORKDIR /code
RUN pip --no-cache-dir install -r requirements.txt && \
    pip list