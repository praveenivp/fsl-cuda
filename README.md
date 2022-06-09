# Ubuntu Container Image for FSL

Modification to make FSLeyes to work somehow. Therefore, a lot of unnecessary packages are there. Need to clean and organise at some point. Most CUDA stuff will break with CUDA 11.2. 

# building
```
docker build -t fsl_ubuntu:devel . 
```
# singularity conatiner conversion
The singularity container will end up in  mounted folder (`/home/<user>`) of the host.

```
 docker run -v /var/run/docker.sock:/var/run/docker.sock -v /home/<user>:/output -v /home/<user>:/tmp --privileged -t --rm quay.io/singularity/docker2singularity fsl_ubuntu:devel

```

# scp container to cluster
```
scp /home/<user>/fsl_ubuntu*.sif <user>@<Cluster IP>:/ptmp/<user>
```

