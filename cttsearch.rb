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
  
  get '/cats' do
    @categories = Categories.all ## Todo: this needs to be sub-cats
    @top_level_categories = Categories.all ## Todo: this needs to be top level cats
    erb :category_explore
  end

  get '/search/?' do
    @query = params[:q]
    @tags = (params[:tags] || "").split(",")
    hits = Search.party(@query, @tags)
    p hits
    @results = SearchResultsOrganiser.new.sort hits
  	erb :results
  end
  
  get '/process' do
    builder = SearchUriBuilder.new(params[:query],[ params[:org_size], params[:user_prof]])
    p "Redirecting to Search?: #{builder.uri}"
    redirect builder.uri
  end

  get '/admin' do
    if params.has_key?('success') and params['success']=='true'    
      @success = true
    else
      @success = false
    end
    @results = Search.party(' ', []) ## get a list of all entries
  	erb :admin_index
  end

  get '/admin/edit' do
    if params.has_key?('success') and params['success']=='true'    
      @success = true
    else
      @success = false
    end
    @resourcetypes = ['ExternalLink', 'YouTubeVideo', 'InternalLink', 'PDF']
    @resource = Resource.get(params['id']) ## get a list of all entries

  	erb :admin_edit
  end

  get '/admin/new' do
    if params.has_key?('success') and params['success']=='true'    
      redirect '/admin?success=true'
    else
      @success = false
    end
    
    @resourcetypes = ['ExternalLink', 'YouTubeVideo', 'InternalLink', 'PDF']
    @resource = {'id' => 0, 'title' => '', 'uri' => '', 'tags' => '', 'shortDescription' => '', 'longDescription' => '', 'resourceType' => ''}

  	erb :admin_edit
  end

  get '/admin/tags/:tags' do
    @tags = (params[:tags] || "").split(",")
    @results = Search.party(' ', @tags) ## get a list of all entries with given tags
    erb :admin_index
  end

end
