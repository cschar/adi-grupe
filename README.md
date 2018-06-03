# Adi 

experiments w/ maps and rails




### Development

rails searchkick gem depends on elasticsearch: 
```
brew install elasticsearch
brew install kibana (optional, opens http://localhost:5601/)

elasticsearch
kibana

rake searchkick:reindex CLASS=Location


bundle exec foreman start  # or bundle exec rails server etc..   
```  

# See Devnotes.md for cheatsheet + ideas

## Heroku

heroku login
heroku create
heroku addons:create heroku-postgresql:hobby-dev
heroku config:set GOOGLE_GEOCODER_API_KEY=<key>
heroku config:set GOOGLE_MAPS_JS_API_KEY=<key>


##### setting up SearchBox for searchkick support in rails
https://github.com/ankane/searchkick#heroku

heroku addons:create searchbox:starter
heroku config:set ELASTICSEARCH_URL=`heroku config:get SEARCHBOX_URL`

heroku run rake searchkick:reindex CLASS=Transaction
heroku run rake searchkick:reindex CLASS=Location

  lib/tasks/<some_task.rake>
heroku run rake gen_location_data
heroku run rake gen_quest_data