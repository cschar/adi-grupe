class ArvenController < ApplicationController
  before_action(:authenticate_user!,  only: :index)

  def index

    # <%= map(:container_id => "first_map", :center => {
    #     :latlng => [51.52238797921441, -0.08366235665359283],
    #     :zoom => 18},
    #     :tile_layer=>"https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw",
    #     :attribution=>'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
    #     '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    #     'Imagery © <a href="http://mapbox.com">Mapbox</a>',
    #     :max_zoom => 4, :id => 'mapbox.streets') %>

        @pods = [{:time => 23},
               {:time => 30},
               {:time => 31}]

      @markers = Marker.all

  end
end
