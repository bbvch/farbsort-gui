FROM ubuntu:17.04
MAINTAINER goerks <michael.burkard@gmx.ch>

# install base tools
RUN apt-get update && \
    apt-get install -y \
        git \
        build-essential \
        qt5-default \
        qtdeclarative5-dev \
        libqt5websockets5-dev \
        qml-module-qtquick-controls2 \
        qml-module-qtquick-extras \
        qml-module-qtquick-templates2 \
        qtdeclarative5-test-plugin \
        qtcreator

# create developer user
RUN useradd -ms /bin/bash developer

USER developer

CMD qtcreator -lastsession

