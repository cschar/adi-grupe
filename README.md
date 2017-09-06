# README

#adi

experiments w/ maps and rails







#### Running Production-ish (Not ready for real production!)

build
> docker build -t adiprod --file '<PATH_TO_DIR>/Dockerfile.prod' .

pass in secret key 
> export SECRET_KEY_BASE=<your_key>

> docker-compose up -e SECRET_KEY_BASE

test its working
> curl localhost:3003

set up db in new postgres container
> docker-compose exec web bash
> rails db:create
> rails db:migrate





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

Then push to your gitlab and let pipeline takeover
```
git add <changeed_file>
git commit -m 'run pipeline!'
git push gitlab_remote
``` 