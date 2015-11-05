# For running a client to bounce off of @ port 9004:
# sudo docker run -d --net=none --expose=[9000] -p 127.0.0.1:9004:9000 -t alljoyn-builder:production
# To connect to this machine after running it

FROM ubuntu

MAINTAINER borromeotlhs@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yq 
# list of packages _actually_ needed doesn't include
# python2.7, unzip, wget, gcc-multilib, gettext
RUN apt-get install build-essential subversion libncurses5-dev zlib1g-dev gawk gcc-multilib flex git-core gettext libssl-dev unzip python2.7 wget -yq
# added this to take advantage of caching
#RUN apt-get install quilt -yq

RUN git clone git://github.com/nneves/openwrt_mips_ar9331_nodejs node
#USER onion
WORKDIR node

RUN useradd -m -d /home/onion -p onion onion && adduser onion sudo && chsh -s /bin/bash onion
RUN chown -R onion:onion .


# This is added as python is needed for node.js gyp formats
RUN ln -s /usr/bin/python2.7 /usr/bin/python
RUN echo 'onion:onion' | chpasswd
USER onion

RUN ./nodejs_v0.10.5_mips_ar9331.sh
