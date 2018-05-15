TODO to add:

#Idea

use gmaps.js routes, and make waze style 

preapproved quests, 
e.g. along canal, into 
5 consective cool spots
etc.

GameMaster admins for each region,
content creators

### In app mesaging like meetup
https://gorails.com/series/in-app-messaging-between-users

#TODO

Make grupes only have 1-2 quests for now
grupe --> has_many quests ,
 limit it to 2, and only grupe creator can make them
gup ---> is_creator , true/false
or grupe ---> user_id / creator_id (userid)
or user ---> grupe_id , the grupe they've created, only allowed 1 



#TODO DEVISE
https://github.com/plataformatec/devise
- user devise omniauthable for omniauth integration for google/twitter
- confirmation email
https://github.com/omniauth/omniauth




edit devise views:

rails g devise:views
rails g devise:controllers

rails g scaffold Firetree name:string body:string user_id:integer
rails g scaffold Transaction street:string city:string zip:string state:string beds:string baths:string sq__ft:string sale_date:datetime price:integer latitude:float longitude:float --force

# database models
https://www.sitepoint.com/master-many-to-many-associations-with-activerecord/

# design
https://startbootstrap.com/template-categories/all/
https://nagoshiashumari.github.io/Rpg-Awesome/
http://v4-alpha.getbootstrap.com/utilities/spacing/#notation

# cool site
https://www.waze.com/carpool/

# geocoder
be rails g geocoder:config
be rails geocode:all CLASS=Transaction SLEEP=0.25 BATCH=100



# quick demo for slack etc..
https://dashboard.ngrok.com/get-started

```
rails s -b 0.0.0.0
./ngrok http 3000
```


# data
https://data.opendatasoft.com/explore/dataset/all-starbucks-locations-in-the-world%40public-us/?refine.city=Ottawa



## messaeg api
https://gist.github.com/rstacruz/1569572



search for grupes with similar quests / quester attributes (likes pingpong/ likes mtg / likes meditation / etc..
search available quests

enter auto-gruper (chooses from premiere / high rated locations) 