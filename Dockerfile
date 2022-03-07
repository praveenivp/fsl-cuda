# for CUDA 8.0, -devel tag is necessary for libcublas.so.8.0
ARG CUDA_TAG=8.0-devel-centos7  # or 9.1-runtime-centos7
FROM nvcr.io/nvidia/cuda:${CUDA_TAG}

LABEL org.opencontainers.image.description="FSL with CUDA ${CUDA_TAG}" \
      org.opencontainers.image.url="https://fsl.fmrib.ox.ac.uk/" \
      org.opencontainers.image.source="https://github.com/FNNDSC/fsl-cuda"

RUN yum install -y file which libpng12 libmng mesa-libGL-devel libgomp libquadmath

WORKDIR /tmp
RUN curl -sSLo fslinstaller.py https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py \
    && python fslinstaller.py -d /usr/local/fsl -V 6.0.4 \
    && rm -rf /usr/local/fsl/src

RUN rm /usr/local/fsl/bin/eddy && ln -s /usr/local/fsl/bin/eddy_cuda /usr/local/fsl/bin/eddy

ENV FSLDIR=/usr/local/fsl
ENV LD_LIBRARY_PATH=/usr/local/fsl/lib:$LD_LIBRARY_PATH \
    FSLOUTPUTTYPE=NIFTI_GZ \
    FSLMULTIFILEQUIT=TRUE \
    FSLTCLSH=$FSLDIR/bin/fsltclsh \
    FSLWISH=$FSLDIR/bin/fslwish \
    PATH=/usr/local/fsl/bin:$PATH

