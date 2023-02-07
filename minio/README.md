
```
root@minIO:~# docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
minio/minio   latest    77c8b98bbb35   18 hours ago   227MB
root@minIO:~# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                                           NAMES
fc03a712e9ab   minio/minio   "/usr/bin/docker-ent…"   16 minutes ago   Up 16 minutes   0.0.0.0:9000-9001->9000-9001/tcp, :::9000-9001->9000-9001/tcp   minio
root@minIO:~#

```
root@minIO:~# docker pull minio/minio
Using default tag: latest

latest: Pulling from minio/minio
a9e23b64ace0: Pull complete
38b71301a1d9: Pull complete
e970cc8203b8: Pull complete
3457efb651f0: Pull complete
cde39d511c55: Pull complete
dab29a7dee43: Pull complete
12b9d5f8927f: Pull complete
Digest: sha256:3ba51aeaf7cb52f5af2bc4537d7b79acb2bed724b8194c09b869f91907041c6c
Status: Downloaded newer image for minio/minio:latest
docker.io/minio/minio:latest
root@minIO:~#

```
root@minIO:~# docker run -d -p 9000:9000 -p 9001:9001 --restart  unless-stopped --name minio -e "MINIO_ACCESS_KEY=minio" -e "MINIO_SECRET_KEY=minio123" -v /mnt/data:/data minio/minio server /data --console-address ":9001"
2b37df657302b6d6acc4205484b24b549a89d79163033099fe2839b19d835adf

```
root@minIO:~# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                                           NAMES
2b37df657302   minio/minio   "/usr/bin/docker-ent…"   11 minutes ago   Up 11 minutes   0.0.0.0:9000-9001->9000-9001/tcp, :::9000-9001->9000-9001/tcp   minio


docker update --restart unless-stopped 2b37df657302

```
harber-cluster
WQ1AYIBUDMXVBDIU3W6E