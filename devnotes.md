TODO to add:

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


# database models
https://www.sitepoint.com/master-many-to-many-associations-with-activerecord/

# design
https://startbootstrap.com/template-categories/all/

# cool site
https://www.waze.com/carpool/

# geocoder
be rails g geocoder:config
be rails geocode:all CLASS=Transaction SLEEP=0.25 BATCH=100

Transaction.near([38.6787626, -121.0352162])
