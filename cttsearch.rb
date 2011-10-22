$:. << File.join(File.dirname(__FILE__), 'lib')
require 'sinatra'
require 'sinatra/base'
require 'sinatra/content_for'
require 'frontend'

class CTTSearch < Sinatra::Base
  helpers Sinatra::ContentFor
  set :root, File.dirname(__FILE__)
  
  get '/' do
    @categories = Categories.all
    erb :index
  end

  get '/search/?' do
    @query = params[:q]
    @tags = (params[:tags] || "").split(",")
    @results = Search.party(@query, @tags)
  	erb :results
  end
  
  get '/process' do
    p params[:query], params[:org_size], params[:user_prof]
    builder = SearchUriBuilder.new(params[:query],[ params[:org_size], params[:user_prof]])
    p "Redirecting to Search?: #{builder.uri}"
    redirect builder.uri
  end
end