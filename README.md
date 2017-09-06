# README

#adi

experiments w/ maps and rails




#### Testing locally w/ Docker

```
docker build -t mytag/adi .
docker run -it --net=host mytag/adi

#do some tests
docker exec -it bundle exec rails test
```


#### docker hub for gitlab runner integration
```
docker login 
docker tag <existing-image> <hub-user>/<repo-name>[:<tag>]
docker push <hub-user>/<repo-name>:<tag>
```



#### Running Production file
