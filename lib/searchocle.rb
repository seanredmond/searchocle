require "searchocle/version"
require "nokogiri"
require "open-uri"

BASE = "http://www.worldcat.org/webservices/catalog/"

module Searchocle
  def self.read(oclc, key=nil)
    Nokogiri::XML(open("%scontent/%s?wskey=%s" % [BASE, oclc, key]))
  end
end
