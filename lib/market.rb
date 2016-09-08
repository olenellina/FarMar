require_relative '../far_mar'

class FarMar::Market
  attr_reader :market_id, :market_name, :address, :city, :county, :state, :zip

  def initialize(market_hash)
    @market_id = market_hash[:market_id].to_i
    @market_name = market_hash[:market_name]
    @address = market_hash[:address]
    @city = market_hash[:city]
    @county = market_hash[:county]
    @state = market_hash[:state]
    @zip = market_hash[:zip]
  end

  def self.all
    markets = []
    CSV.open("./support/markets.csv", "r").each do |line|
      market_hash = {market_id: line[0], market_name: line[1], address: line[2], city: line[3], county: line[4], state: line[5], zip:
        line[6]}
      markets << FarMar::Market.new(market_hash)
    end
    return markets

  end

  def self.find(id)
    markets = self.all
    markets.length.times do |x|
      if markets[x].market_id == id
        return markets[x]
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
