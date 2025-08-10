# DarkDock

Host a website securely and privately on the Dark Web using Docker and Tor. This project sets up a Tor Onion Service that makes your site accessible via a `.onion` address while protecting your privacy.

### About

This project allows you to host a website on the Dark Web using a Docker container connected to the Tor network. It supports multiple architectures (x86_64 and ARM) and provides a simple way to run a private, anonymous Onion Service.

### Security Tips for Using the Dark Web

- **Use a VPN** before opening Tor to hide your real IP.  
- **Use the official Tor Browser** to stay anonymous.  
- **Lock down your server ports** so only the ones you need (like SSH) are open. 

### 🛡 Note on Docker Security

When you use **DarkDock**, a lot of the tricky security stuff is already taken care of:

- **Tor and nginx** run safely inside their own container, away from the rest of your system.  
- The **hidden service ports** aren’t open to the internet — only Tor can reach them.  
- Your **`.onion` address and keys** stay inside the container and can’t be seen unless you choose to share them.  
- If something goes wrong, the container can be quickly rebuilt, keeping the rest of your system safe.

---
### How to Build & Run DarkDock
**To build the container in x86_T64 Architecture:**

```sh
sudo docker build -t tordocker -f Dockerfile .
```

**To build the container in arm Architecture:**

```sh
sudo docker build -f tordocker DockerFilePi .
```

**To run the image for testing:**

```sh
sudo mkdir -p /docker/torweb/nginx 
sudo docker run \
  --name darkdock \
  -h darkdock \
  -d \
  -p 80:80 -p 443:443 -p 9050:9050 \
  -v /docker/torweb/nginx:/var/www/html/ \
  --restart unless-stopped \
  darkdock
```

### Get your Onion address
```sh
docker logs darkdock
```
---


