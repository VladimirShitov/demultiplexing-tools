FROM lindsayliang/popscle 
ENV PATH="/home/popscle/bin:${PATH}" 
RUN apt update && apt install software-properties-common -y && add-apt-repository ppa:deadsnakes/ppa -y && apt update && apt upgrade -y && apt install python3.9 -y && apt install python3.9-distutils -y && apt install python3.9-dev -y
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3.9 get-pip.py #pip
RUN python3.9 -m pip install numpy  pandas pysam PyVCF scikit-learn scipy statistics vireoSNP && git clone https://github.com/jon-xu/scSplit #scsplit + vireo
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update
RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda config --add channels bioconda && conda config --add channels conda-forge && conda install cellsnp-lite -y #cellsnp-lite
RUN git clone https://github.com/wheaton5/souporcell.git
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >> rust_installer.sh &&  bash rust_installer.sh -y #&& PATH="/home/.cargo/env:${PATH}"
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cd /home/souporcell/souporcell && cargo build --release && cd /home/souporcell/troublet && cargo build --release #souporcell
RUN git clone https://github.com/lh3/minimap2 && cd minimap2 && make #minimap for souporcell
RUN python3.9 -m pip install --upgrade https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.12.0-py3-none-any.whl #tensorflow for souporcell
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && tar -vxjf samtools-1.9.tar.bz2 && cd samtools-1.9 && make
ENV PATH="$PATH:/home/samtools-1.9"
ENV PATH="$PATH:/home/minimap2"
RUN wget https://github.com/10XGenomics/vartrix/archive/v1.1.20.tar.gz && tar xvzf v1.1.20.tar.gz && cd /home/vartrix-1.1.20 && cargo build
ENV PATH="$PATH:/home/vartrix-1.1.20/target/debug#"
#RUN  # alias scSplit=’python3.9 scSplit/scSplit’ && alias souporcell_pipeline.py=’python3.9 souporcell/souporcell_pipeline.py’ && alias demuxlet=’popscle demuxlet’ && alias freemuxlet=’popscle freemuxlet’ 
RUN conda install -c bioconda freebayes #freebayes
