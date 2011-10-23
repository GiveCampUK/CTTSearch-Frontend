require 'uri'

class String
  def escaped
    URI.escape(self, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end
end