require 'csv'
require_relative '../far_mar'
require 'awesome_print'
require_relative './vendor'

class FarMar::Market
  attr_reader :markets, :market_id, :market_name, :address, :city, :county, :state, :zip
  @@markets = []

  def initialize(market_hash)
    @market_id = market_hash[:market_id].to_i
    @market_name = market_hash[:market_name]
    @address = market_hash[:address]
    @city = market_hash[:city]
    @county = market_hash[:county]
    @state = market_hash[:state]
    @zip = market_hash[:zip]

    @@markets << self
  end

  def self.csv_processor(csvfile)
       CSV.open(csvfile, "r").each do |line|
         market_hash = {market_id: line[0], market_name: line[1], address: line[2], city: line[3], county: line[4], state: line[5], zip:
           line[6]}
         FarMar::Market.new(market_hash)
       end
       return @@markets
  end

  def self.all
    return @@markets
  end

  def self.find(id)
    @@markets.length.times do |x|
      if @@markets[x].market_id == id
        return @@markets[x]
      end
    end
  end

  def vendors
    vendor_collection = []
    vendors = FarMar::Vendor.all
      vendors.length.times do |x|
        if vendors[x].market_id == self.market_id
          vendor_collection << vendors[x]
        end
      end
    return vendor_collection
  end

end
