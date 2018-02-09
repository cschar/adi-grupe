TODO to add:

#Idea

use gmaps.js routes, and make waze style 
preapproved quests, 
e.g. along canal, into 
5 consective cool spots
etc.

### In app mesaging like meetup
https://gorails.com/series/in-app-messaging-between-users



#TODO 
text search using postgres
for announcements

or rails gem...
http://rachbelaid.com/postgres-full-text-search-is-good-enough/

#TODO DEVISE
https://github.com/plataformatec/devise
- user devise omniauthable for omniauth integration for google/twitter
- confirmation email
https://github.com/omniauth/omniauth

#TODO: ADMIN
#use an admin in the backend
http://guides.railsgirls.com/backend-with-active-admin
#integreate the admin w/ cancancan roles
https://github.com/CanCanCommunity/cancancan

TODO: rewrite jquery prototype in react
https://github.com/PaulLeCam/react-leaflet/blob/master/docs/Components.md#marker

latlng:
45.659,-76.062



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
```
 "id":488388606,
               "comment":"what is the price for 3 nights?",
               "link":"https://www.meetup.com/ottawa-social/events/246836137/comments/488388606/",
               "created":1517709197000,
               "like_count":0,
               "member":{  
                  "id":203428624,
                  "name":"Emefa",
                  "photo":{  
                     "id":274427329,
                     "highres_link":"https://secure.meetupstatic.com/photos/member/b/8/e/1/highres_274427329.jpeg",
                     "photo_link":"https://secure.meetupstatic.com/photos/member/b/8/e/1/member_274427329.jpeg",
                     "thumb_link":"https://secure.meetupstatic.com/photos/member/b/8/e/1/thumb_274427329.jpeg",
                     "type":"member",
                     "base_url":"https://secure.meetupstatic.com"
                  },
                  "web_actions":{  
                     "group_profile_link":"https://www.meetup.com/ottawa-social/members/203428624"
                  },
                  "event_context":{  
                     "host":false
                  }
               },
               "self":{  
                  "liked":false,
                  "actions":[  
                     "flag_spam",
                     "like"
                  ],
                  "notifications":"on"
               },
               "web_actions":{  
                  "report_abuse":"https://www.meetup.com/report_abuse/event_comment/488388606"
               }
            },
  ```