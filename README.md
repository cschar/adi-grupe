# Adi-Grupe

Maps/Rails Group up app

### Setting up 


```
bundle install

rails db:migrate

rake gen_location_data 
rake gen_quest_data



alias 'be'='bundle exec'
be foreman start  # or bundle exec rails server etc..   

# https://github.com/javan/whenever
# see background jobs set up in config/schedule.rb
whenever  
# write the jobs to crontab
whenever --update-crontab
```  


rails searchkick gem depends on elasticsearch: 
```
brew install elasticsearch
brew install kibana (optional, opens http://localhost:5601/)
elasticsearch
kibana

rake searchkick:reindex CLASS=Location
```


### Development / Testing

```
be rake about

#builds into public/packs-test, set in config/webpacker.yml
RAILS_ENV=test ./bin/webpack  

## Acceptance tests: chrome driver via capybara
be rspec

## integration
be rails test test/integration/*
```



# See Devnotes.md for cheatsheet + ideas

## Heroku

```
heroku login
heroku create
heroku addons:create heroku-postgresql:hobby-dev
heroku addons:create heroku-redis:hobby-dev   ## a/b split testing 

heroku config:set GOOGLE_GEOCODER_API_KEY=<key>
heroku config:set GOOGLE_MAPS_JS_API_KEY=<key>
heroku run rails db:migrate


#when pushing new code
git push heroku master  #etc...
heroku run rails db:migrate
heroku ps:restart
```


```
##### setting up SearchBox for searchkick support in rails
https://github.com/ankane/searchkick#heroku


heroku addons:create searchbox:starter
heroku config:set ELASTICSEARCH_URL=`heroku config:get SEARCHBOX_URL`

heroku run rake searchkick:reindex CLASS=Transaction
heroku run rake searchkick:reindex CLASS=Location

  lib/tasks/<some_task.rake>
heroku run rake gen_location_data
heroku run rake gen_quest_data

# Heroku wont use whenever crontab, uses 'Scheduler' instead
https://devcenter.heroku.com/articles/scheduler
heroku addons:create scheduler:standard
```