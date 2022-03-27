# Running this job on the Hyperion Cluster

```
# add proxy
git config --global http.proxy http://hpc-proxy00.city.ac.uk:3128
# clone (https only)
git clone https://github.com/dsikar/hyperion
# change directory
cd hyperion/fluent
# schedule job
sbatch runfluent.sh
```
