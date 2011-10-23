$:. << File.join(File.dirname(__FILE__), 'lib')
require 'sinatra'
require 'sinatra/base'
require 'sinatra/content_for'
require 'frontend'

class CTTSearch < Sinatra::Base
  helpers Sinatra::ContentFor
  set :root, File.dirname(__FILE__)
  
  get '/' do
    @categories = Search.cats
    erb :index
  end
  
  get '/cats/:id' do
    @categories = Search.cats
    @category = Search.cat(params[:id])
    erb :category_explore
  end

  get '/search/?' do
    @query = params[:q]
    @tags = (params[:tags] || "").split(",")
    hits = Search.party(@query, @tags)
    @results = SearchResultsOrganiser.new.sort hits
  	erb :results
  end
  
  get '/process' do
    builder = SearchUriBuilder.new(params[:query],[ params[:org_size], params[:user_prof]])
    p "Redirecting to Search?: #{builder.uri}"
    redirect builder.uri
  end

  get '/admin' do
    @results = Search.party(' ', []) ## get a list of all entries
  	erb :admin_index
  end

  get '/admin/edit' do
    @resourcetypes = ['ExternalLink', 'YouTubeVideo', 'InternalLink', 'PDF']
    @resource = Resource.get(params['id']) ## get a list of all entries

  	erb :admin_edit
  end

  get '/admin/new' do
    @resourcetypes = ['ExternalLink', 'YouTubeVideo', 'InternalLink', 'PDF']
    @resource = {'id' => 0, 'title' => '', 'uri' => '', 'tags' => '', 'shortDescription' => '', 'longDescription' => '', 'resourceType' => ''}

  	erb :admin_edit
  end

end
