FROM nvidia/cuda:11.2.1-devel-ubuntu18.04

RUN apt update && \
    apt install -y libxt6 htop nano
    #apt clean && \
   # rm -rf /var/lib/apt/lists/*

# Install some fsl dependencies
RUN apt update && apt install -y --fix-missing libpng-tools libpng-dev libmng2 libgomp1 libquadmath0 curl python3 python bc


LABEL org.opencontainers.image.description="FSL with CUDA ${CUDA_TAG}" \
      org.opencontainers.image.url="https://fsl.fmrib.ox.ac.uk/" \
      org.opencontainers.image.source="https://github.com/FNNDSC/fsl-cuda"

WORKDIR /tmp
RUN curl -sSLo fslinstaller.py https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py \
    && python fslinstaller.py -d /usr/local/fsl -V 6.0.4 \
    && rm -rf /usr/local/fsl/src

RUN rm /usr/local/fsl/bin/eddy && ln -s /usr/local/fsl/bin/eddy_cuda /usr/local/fsl/bin/eddy

#FSL eyes modification: needs opengl , fonts and locale
RUN apt install -y cmake pkg-config mesa-utils libglu1-mesa-dev freeglut3-dev mesa-common-dev libglew-dev libglfw3-dev libglm-dev libao-dev libmpg123-dev

RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

RUN apt-get install -y --no-install-recommends fontconfig ttf-mscorefonts-installer locales
# refresh system font cache
RUN fc-cache -f -v
# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV FSLDIR=/usr/local/fsl
ENV LD_LIBRARY_PATH=/usr/local/fsl/lib:$LD_LIBRARY_PATH \
    FSLOUTPUTTYPE=NIFTI_GZ \
    FSLMULTIFILEQUIT=TRUE \
    FSLTCLSH=$FSLDIR/bin/fsltclsh \
    FSLWISH=$FSLDIR/bin/fslwish \
    PATH=/usr/local/fsl/bin:$PATH

