# Adi <span style="color:blue"> geo game.</span>

experiments w/ maps and rails




### Development

rails searchkick gem depends on elasticsearch: 
```
brew install elasticsearch
brew install kibana (optional, opens http://localhost:5601/)

elasticsearch
kibana

rake searchkick:reindex CLASS=<searchkick classes>   
```  

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

