class HelloWorldController < ApplicationController
  def index
    #pass in reducer name here
    @hello_world_props = {
        myRed: { name: "stranger",
                 position: [51.505, -0.09],
                 # markers: Marker.all
                 markers: Marker.where(user_id:1)
        },
        name: "Stranger" ,
        position: [51.505, -0.09]
    }
    @react_props = { rname: 'kyle'}
  end
end
