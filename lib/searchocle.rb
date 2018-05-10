require "searchocle/version"
require "nokogiri"
require "open-uri"

module Searchocle
  HOST = "worldcat.org"
  BASE = "/webservices/catalog/"

  PARAMS = {
    :read => [:wskey, :servicelevel, :recordSchema],
    :sru => [:wskey, :query, :recordSchema, :startRecord, :maximumRecords,
             :sortKeys, :frbrGrouping, :servicelevel]
  }

  def self.read(oclc, key, options={})
    options[:wskey] = key
    url = URI::HTTP.build(host: HOST,
                          path: "%s%s%s" % [BASE, "content/", oclc],
                          query: URI.encode_www_form(filter_params(:read, options)))
    Nokogiri::XML(open(url))
  end

  def self.sru(q, key, options={})
    options[:wskey] = key
    options[:query] = q
    url = URI::HTTP.build(host: HOST,
                          path: "%s%s" % [BASE, "search/worldcat/sru/"],
                          query: URI.encode_www_form(filter_params(:sru, options)))
    Nokogiri::XML(open(url))
  end    

  def self.filter_params(m, p)
    p.select{|k, v| PARAMS[m].include?(k)}
  end
end
