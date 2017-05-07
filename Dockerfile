FROM daocloud.io/ubuntu:14.04

RUN mkdir -p /usr/app/src
WORKDIR /usr/app/src
ADD . /usr/app/src

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:gophers/archive
RUN apt-get update
RUN apt-get install -y make
RUN apt-get install -y golang-1.8
RUN apt-get install -y git

ENV PATH=$PATH:/usr/lib/go-1.8/bin
RUN mkdir -p ~/go/bin
RUN mkdir -p ~/go/src

RUN make release-server
RUN make release-client

CMD /usr/app/src/bin/ngrokd -domain="ngrok.arthurmao.me" -httpAddr=":8088" -httpsAddr=":8089"
