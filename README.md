# Adi <span style="color:blue"> geo game.</span>

experiments w/ maps and rails




### Development

rails searchkick gem depends on elasticsearch: 
```
brew install elasticsearch
brew install kibana (optional, opens http://localhost:5601/)

elasticsearch
kibana   
```  




#### Running Production-ish (Not ready for real production!)

build
> docker build -t adiprod --file '<PATH_TO_DIR>/Dockerfile.prod' .

pass in secret key 
```
export SECRET_KEY_BASE=<your_key>
docker-compose up  #dont need to pass in, will take environment from shell
#or detached 
```
test its working
> curl localhost:3003

set up db in new postgres container
```
docker-compose exec web bash
rails db:create
rails db:migrate
```

monitor detached mode
```
docker-compose up -d
docker-compose logs --follow
docker-compose stop
docker-compose start
```


#### Testing locally w/ Docker

```
docker build -t mytag/adi .
docker run -it --net=host mytag/adi

#do some tests
docker exec -it bundle exec rails test
```

##### (hackish) Develop locally w/ docker-compose

uncomment out the volume.
when a new component is needed:
```
# update code, add a gem etc..
# modify docker-compose cmd for web service:
git pull / git commit 
docker-compose stop
cmd: bash -c "bundle install; runserver etc.."
outside container...
cd client && yarn install && cd ..
bundle exec rake assets:precompile
docker-compose up
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


###Background Tasks

apply rps game logic on lmarkers
> rake rps_game_logic_on_lmarkers
