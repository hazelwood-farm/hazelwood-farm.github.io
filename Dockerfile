# Import ubuntu image
FROM ubuntu:latest

# Set working directory
# WORKDIR /app

# Link /app to current this directory
COPY . /app

# Install neccessary denpendencies
RUN sudo apt-get update
RUN sudo apt-get install wget software-properties-common
RUN sudo add-apt-repository ppa:ubuntu-toolchain-r/test
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
RUN sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7 main"
RUN sudo apt-get update
RUN sudo apt-get install build-essential clang-7 lld-7 g++-7 cmake ninja-build libvulkan1 python python-pip python-dev python3-dev python3-pip libpng16-dev libtiff5-dev libjpeg-dev tzdata sed curl unzip autoconf libtool rsync git-core
RUN pip2 install --user setuptools
RUN pip3 install --user setuptools

# Update clang (recommended)
RUN sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-7/bin/clang++ 170
RUN sudo update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-7/bin/clang 170

RUN git clone https://github.com/carla-simulator/carla
RUN make PythonAPI