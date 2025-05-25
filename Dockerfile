FROM ubuntu:20.04

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y sudo git wget psmisc

WORKDIR /root

ENV DEBIAN_FRONTEND=noninteractive

COPY install install
COPY Pipfile Pipfile.lock .
RUN ./install/autobahn
RUN ./install/node
RUN ./install/ruby

CMD ["/bin/bash"]
