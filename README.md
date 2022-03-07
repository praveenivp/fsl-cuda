# Container Image for FSL Eddy With CUDA

`eddy_cuda` only supports specific (old) versions of CUDA.
This repository provides a `Dockerfile` for building
[FSL](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FSL)
inside a container image with
[CUDA](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuda).

Works with Singularity 3.2.1.

https://hub.docker.com/r/fnndsc/fsl

## Compatability

We were only able to get this working on **Tesla K80** with CUDA 8.0.

We tried these other cards with both CUDA 8.0 and 9.1 but `eddy_cuda`
would crash:

- GTX 950
- TITAN V
- RTX A6000

