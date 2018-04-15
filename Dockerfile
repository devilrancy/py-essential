FROM python:2.7

MAINTAINER Surisetty, Naresh "naresh@naresh.co"

# Copy oracle client libraries
COPY oracle.zip /tmp/

# Add config files and provide permission
ADD oracle.conf /etc/ld.so.conf.d/oracle.conf
ADD oracle.sh /etc/profile.d/oracle.sh
RUN chmod +x /etc/ld.so.conf.d/oracle.conf
RUN chmod +x /etc/profile.d/oracle.sh

# Install Debian Jessie packages
RUN apt-get update -y && \
    apt-get install -y unzip && \
    apt-get install -y dpkg-dev && \
    apt-get install -y debhelper && \
    apt-get install -y gcc && \
    apt-get install -y g++ && \
    apt-get install -y libc-dev && \
    apt-get install -y unixodbc-dev && \
    apt-get install -y musl-dev && \
    apt-get install -y openssl && \
    apt-get install -y postgresql && \
    apt-get install -y libpq-dev && \
    apt-get install -y postgresql-client && \
    apt-get install -y postgresql-client-common && \
    apt-get install -y libaio1 && \
    apt-get install -y tk-dev && \
    apt-get install -y python-tk && \
    unzip "/tmp/oracle.zip" -d /usr/lib/ && \
    /etc/profile.d/oracle.sh && \
    ldconfig && \
    apt-get -s clean all

# Add requirements and install them
ADD requirements.txt /code/
WORKDIR /code
RUN pip --no-cache-dir install -r requirements.txt && \
    pip list