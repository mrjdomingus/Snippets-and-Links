# Fix for missing libpng12.so.0 file

Via: [https://askubuntu.com/questions/978294/how-to-fix-libpng12-so-0-cannot-open-shared-object-file-no-such-file-or-direc](https://askubuntu.com/questions/978294/how-to-fix-libpng12-so-0-cannot-open-shared-object-file-no-such-file-or-direc)

```
wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb \
  && dpkg -i /tmp/libpng12.deb \
  && rm /tmp/libpng12.deb
```

Run as superuser!

