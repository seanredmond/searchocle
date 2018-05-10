require "searchocle/version"
require "nokogiri"
require "open-uri"

HOST = "worldcat.org"
BASE = "/webservices/catalog/"

module Searchocle
  def self.read(oclc, key, options={})
    options[:wskey] = key
    url = URI::HTTP.build(host: HOST,
                          path: "%s%s%s" % [BASE, "content/", oclc],
                          query: URI.encode_www_form(filter_params(options)))
    puts url
    Nokogiri::XML(open(url))
  end

  def self.filter_params(p)
    p.select{|k, v| [:wskey, :servicelevel, :recordSchema].include?(k)}
  end
end
