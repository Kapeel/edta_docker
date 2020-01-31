FROM continuumio/miniconda3

#RUN apt-get install libgomp1
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge
RUN conda config --add channels r

RUN conda create -n EDTA
RUN conda install -c bioconda repeatmodeler mdust
RUN conda install -c bioconda edta 
## Install Repeat Masker libraries steps included courtesy @wangshun1211 for contributions
RUN cd /opt && wget https://github.com/lfaino/LoReAn/raw/noIPRS/third_party/software/RepeatMasker.Libraries.tar.gz && \
    tar -zxf RepeatMasker.Libraries.tar.gz && rm -rf /opt/conda/share/RepeatMasker/Libraries && \
    mv ./Libraries /opt/conda/share/RepeatMasker/. && chmod -R 755 /opt/conda/share/RepeatMasker/Libraries && \
    rm -f RepeatMasker.Libraries.tar.gz 

RUN git clone https://github.com/oushujun/EDTA.git
RUN echo "source activate EDTA" > ~/.bashrc
ENV PATH /opt/conda/envs/env/bin:$PATH

ENTRYPOINT [ "/EDTA/EDTA.pl" ]
