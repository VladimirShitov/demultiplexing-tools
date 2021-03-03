FROM lindsayliang/popscle
RUN apt update && apt install software-properties-common -y && add-apt-repository ppa:deadsnakes/ppa -y && apt update && apt upgrade -y && apt install python3.9 -y && apt install python3.9-distutils -y && apt install python3.9-dev -y
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3.9 get-pip.py #pip
RUN apt-get install libncursesw5-dev && apt-get install liblzma-dev && cd /usr/bin && wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2 && tar -vxjf htslib-1.9.tar.bz2 && cd htslib-1.9 && make && cd #htslib
RUN python3.9 -m pip install numpy  pandas pysam PyVCF scikit-learn scipy statistics scSplit vireoSNP #scsplit + vireo
