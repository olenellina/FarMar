# Market Class

require './far_mar'

class FarMar::Market < FarMar::Shared
  attr_reader :id, :market_name, :address, :city, :county, :state, :zip

  # Reading in the associated csv file for this class and storing it in a constant (for efficency).
  MARKETS_DATA = CSV.read("./support/markets.csv")

  def initialize(market_hash)
    @id = market_hash[:market_id].to_i
    @market_name = market_hash[:market_name]
    @address = market_hash[:address]
    @city = market_hash[:city]
    @county = market_hash[:county]
    @state = market_hash[:state]
    @zip = market_hash[:zip]
  end

  # self.all uses the constant MARKETS_DATA to populate a hash. That hash is then used to create objects that are then stored in the sales array (local variable). It is that array that is returned anytime self.all is called.
  def self.all
    markets = []
    MARKETS_DATA.each do |market|
      market_hash = {market_id: market[0], market_name: market[1], address: market[2], city: market[3], county: market[4], state: market[5], zip: market[6]}
      markets << FarMar::Market.new(market_hash)
    end
    return markets
  end

  # vendors returns a collection of vendors objects for the market id associated with the market object calling this method. It will return an empty array if no vendors are associated with the market.
  def vendors
    vendor_collection = []
    vendors = FarMar::Vendor.all
      vendors.each do |vendor|
        if vendor.market_id == self.id
          vendor_collection << vendor
        end
      end
    return vendor_collection
  end

end
