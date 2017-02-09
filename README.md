# scylla-apt-mirror

An Docker image of Scylla apt repository mirror, to make Scylla installable on
isolated network.

## setup mirror server

Install docker on the server. Please note that docker package name isn't "docker".
```
sudo apt update
sudo apt install docker.io
```

Fetch this repository.
```
sudo apt install git
git clone https://github.com/syuu1228/scylla-apt-mirror.git
```

Build an docker image.
```
cd scylla-apt-mirror
sudo docker build -t scylla-apt-mirror .
```

Run the docker image, bind the container to port 80.
```
sudo docker run -d -p 80:80 scylla-apt-mirror
```

Test the container with curl command, to check nginx serving repo image correctly.
```
curl http://localhost/downloads.scylladb.com/deb/ubuntu/dists/trusty/scylladb-1.6/multiverse/binary-amd64/Packages
```
If you see package informations on a terminal, it works correctly.

## use the mirror repo

Add mirror repository on /etc/apt/sources.list.d (replace <IP ADDR> to server IP address).
```
sudo sh -c "echo 'deb  [arch=amd64] http://<IP ADDR>/downloads.scylladb.com/deb/ubuntu trusty scylladb-1.6/multiverse' > /etc/apt/sources.list.d/scylla-1.6-trusty.list"
```

Install scylla.
```
sudo apt update
sudo apt install scylla
```
