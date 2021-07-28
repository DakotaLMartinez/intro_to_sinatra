class ApplicationController < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, "*" 
    set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
    set :expose_headers, ['Content-Type']
  end

  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    200
  end
  get "/paintings" do 
    paintings = Painting.all
    paintings.to_json(include: :artist)
  end

  # post "/new_painting" do 
  #   painting_params = params.select do |k,v|
  #     ["image", "title", "artist_name", "date", "width", "height"].include?(k)
  #   end
  #   painting = Painting.create(painting_params)
  #   painting.to_json(include: :artist)
  # end

  patch "/paintings/:id/upvote" do 
    painting = Painting.find(params[:id])
    painting.increment!(:votes)
    painting.to_json(include: :artist)
  end
  # method "URL" do
    
  # end
  
  post "/new_painting" do 
    puts params.inspect
    painting_params = params.select do |key|
      ["image", "title", "artist_name", "date", "width", "height"].include?(key)
    end
    binding.pry
    painting = Painting.create(painting_params)
    painting.to_json
  end

end
