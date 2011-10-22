require 'uri'

module Categories
  # TODO: Re-Implement with Actual Calls Once API Becomes Available
  
  def self.all
    [
      { :title => "Email", :blurb => "How to set up and configure email", :tags => [:email] },
      { :title => "Getting on the Web", :blurb => "What's a host? How to get your charity online.", :tags => [:web, :hosting] },
      { :title => "Donations", :blurb => "How to process payments. PCI compliance", :tags => [:payments, :dontations]}
    ]
  end
end