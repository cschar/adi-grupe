class HelloWorldController < ApplicationController
  def index
    @hello_world_props = { name: "Stranger" }
    @react_props = { rname: 'kyle'}
  end
end
