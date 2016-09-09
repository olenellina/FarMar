# Market Class

require_relative '../far_mar'

class FarMar::Market
  attr_reader :market_id, :market_name, :address, :city, :county, :state, :zip

  # Reading in the associated csv file for this class and storing it in a constant (for efficency)
  MARKETS_DATA = CSV.read("./support/markets.csv")

  def initialize(market_hash)
    @market_id = market_hash[:market_id].to_i
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
    MARKETS_DATA.length.times do |x|
      market_hash = {market_id: MARKETS_DATA[x][0], market_name: MARKETS_DATA[x][1], address: MARKETS_DATA[x][2], city: MARKETS_DATA[x][3], county: MARKETS_DATA[x][4], state: MARKETS_DATA[x][5], zip:
        MARKETS_DATA[x][6]}
      markets << FarMar::Market.new(market_hash)
    end
    return markets
  end

 # self.find returns the object associated with the id or raises an ArgumentError if the id cannot be found
  def self.find(id)
    markets = self.all
    market = nil
    markets.length.times do |x|
      if markets[x].market_id == id
        market = markets[x]
      end
    end
    if market.nil?
      raise ArgumentError.new("This id cannot be found")
    else
      return market
    end
  end

  # vendors returns a collection of vendors objects for the market id associated with the market object calling this method. It will return an empty array if no vendors are associated with the market.
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
