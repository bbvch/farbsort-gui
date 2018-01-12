## About
QML user interface for farbsort showcase.

## Usage

### Checkout

    git clone https://github.com/bbvch/farbsort-gui.git

### Build

    mkdir build && cd build
    qmake ../farbsort-gui.pro
    make -j $(nproc)

### Run

#### Real target

Start [farbsort-websocket](https://github.com/bbvch/farbsort-websocket) service on beaglebone black. 

    ./farbsort-gui --ip-address WEBSOCKET_HOST_IP


#### Simulated target

    ./farbsort-gui --simulation

### Using docker environment

#### Create container

    docker build -t farbsort-gui/qt-dev-env .

#### Start IDE

    # create temporary folder for qtcreator project files
    mkdir config
    
    # run container with created config folder
    docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v ${PWD}:/home/${USER}/farbsort-gui -v ${PWD}/config:/home/${USER}/.config/QtProject --workdir=/home/${USER}/farbsort-gui farbsort-gui/qt-dev-env
