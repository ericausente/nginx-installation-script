# install-nginx-plus
Script to install NGINX Plus or NGINX OSS on Ubuntu

# Assumptions
For Nginx Plus - You have downloaded .crt & .key files and are available in your /tmp directory

# Other Ideas
I was trying to capture the Ubuntu Codename for the OSS Install; 
Will work on it later, but if you have already figured it out, please help. 
The following gives me output 'bionic'

```
lsb_release --codename | cut -f2
```

I want to capture that and insert it in the followign step in place of <CODENAME>:

```
deb https://nginx.org/packages/mainline/ubuntu/ <CODENAME> nginx
deb-src https://nginx.org/packages/mainline/ubuntu/ <CODENAME> nginx
```
