# Docker ftp server

* This is a very simple docker image for running ftp server.
* This configuration was created in order to run tests. Do not use it in production!

* Building image
```sh
docker build -t ftp .
```

* Starting the container
```sh
docker run -itd -p 20-22:20-22/tcp -e FTP_LOGIN=testuser -e FTP_PASSWORD=testpassword --name=ftp-server ftp
```

* Now you can connect to the server via FTP or SFTP  