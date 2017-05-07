FROM daocloud.io/ubuntu:14.04

RUN mkdir -p /usr/app/src
WORKDIR /usr/app/src
ADD . /usr/app/src

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:longsleep/golang-backports
RUN apt-get update
RUN apt-get install -y make
RUN apt-get install -y golang-go
RUN apt-get install -y git


RUN make release-server
RUN make release-client

CMD /usr/app/src/bin/ngrokd -domain="ngrok.arthurmao.me" -httpAddr=":8088" -httpsAddr=":8089"
