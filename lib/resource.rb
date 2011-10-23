require 'json'
require 'uri'
require 'open-uri'

class Resource
  def self.get(id)
    
    path = "/Resource/Index/#{id}"
    query_api path
  end
  
  private
  
  def self.base_uri
    "http://searchparty-1.apphb.com"
  end
  
  def self.query_api(path)
    begin
      uri = "#{base_uri}#{path}"
      JSON.parse(URI.parse(uri).read)
    rescue => ex
      p ex.inspect
    end
  end
end
