class HelloWorldController < ApplicationController
  def index
    #pass in reducer name here
    @hello_world_props = {
        myRed: { name: "[][]",
                 position: [51.505, -0.09],
                 lmarkers: Lmarker.all
                 # markers: Marker.where(user_id:1)
        },
        # will cause client error not recognzing these
        # (NO reducer with that name created)
        # name: "Stranger" ,
        # position: [51.505, -0.09]
    }
    @react_props = { rname: 'kyle'}
  end
end
