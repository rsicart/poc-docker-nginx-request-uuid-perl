PoC nginx with request uuid
===========================

Add example virtualhost:
```
sudo echo "127.0.0.1	perl.example.com" >> /etc/hosts
```

Build container image from Dockerfile:
```
docker build -t nginx_requestid --file ./Dockerfile.perl .
```

Run container:
```
docker run -ti --name nginx-uuid -d -p 8080:80 -p 8443:443 nginx_requestid
```

Test, in a terminal:
```
watch curl -I -k -L 'https://perl.example.com:8443/'
```

Check logs in different terminal:
```
watch 'docker logs nginx-uuid | tail -f'
```
