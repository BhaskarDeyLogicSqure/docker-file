# Docker Learnings Summary

## 🐳 Dockerfile Setup Examples

### Basic Ubuntu + Node.js Setup

```dockerfile
FROM ubuntu
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get upgrade -y
RUN apt-get install -y nodejs
COPY package.json package-lock.json ./
COPY main.js ./
RUN npm install --legacy-peer-deps
ENTRYPOINT ["node", "main.js"]
```

### Optimized Alpine + Multi-Stage Build

```dockerfile
FROM node:24.2.0-alpine3.22 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps || npm cache clean --force
COPY . .

FROM node:24.2.0-alpine3.22 as runner
WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["npm", "run", "dev"]
EXPOSE 3000
EXPOSE 9229
```

---

## ✅ Things Learned

### 🔧 Image Creation & Optimization

* Created Docker images from both `ubuntu` and `node:alpine`
* Used multi-stage builds for efficiency
* Learned how to install `nodejs`, `curl`, `nodemon`
* Built and ran Node.js apps inside containers
* Used `--legacy-peer-deps` for npm compatibility

### 🌐 Docker Networking

* Learned about `bridge`, `host`, and `macvlan` networks
* Created custom Docker networks:

  ```bash
  docker network create asgard
  docker network create -d macvlan \
    --subnet=192.168.68.0/24 \
    --gateway=192.168.68.1 \
    -o parent=wlp0s20f3 macvlan_net
  ```
* Inspected networks with `docker inspect bridge` and `docker network ls`
* Used `--network=host` and `--network=<custom>`

### 📂 Volume Mounting & Real-Time Sync

* Mounted local folders to containers:

  ```bash
  docker run -it -v $(pwd):/app my-img
  docker run -it -v /path/to/folder:/home/app my-img
  ```
* Observed real-time file sync inside containers

### 🚀 Docker Hub

* Logged in using `docker login`
* Tagged and pushed custom images:

  ```bash
  docker tag my-img bhaskardey772/docker-node
  docker push bhaskardey772/docker-node
  ```
* Pulled and ran published images

### 🐙 Git + Docker Workflow

* Used `git init`, `git remote set-url`, `git push`, and branching commands
* Integrated Docker builds and version control cleanly

---

## 🛠️ Common Docker Commands Used

```bash
# Run containers
  docker run -it ubuntu
  docker run -it node
  docker run -it -p 3000:3000 my-img

# Mount volumes
  docker run -it -v $(pwd):/app my-img

# Start, stop, exec
  docker start <container>
  docker stop <container>
  docker exec -it <container> bash/sh

# Build & push images
  docker build -t my-img .
  docker push bhaskardey772/docker-node

# Network setup
  docker network ls
  docker network inspect bridge

# Check IP routes
  ip route
  ip address show
```

---

## 🔁 Issues Faced & Debugging

* Network didn't work in some custom `macvlan` setups
* Used `ip route` and `ip address show` to debug network
* Repeated tests with volume mount paths to verify folder visibility

---

This document captures Bhaskar Dey's Docker learning journey — from running simple containers to complex networked and volume-synced environments with custom image builds and registry pushes.
