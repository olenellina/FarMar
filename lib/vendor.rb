# Vendor Class

require_relative '../far_mar'

class FarMar::Vendor
  attr_reader :vendor_id, :vendor_name, :num_employees, :market_id

  # Reading in the associated csv file for this class and storing it in a constant (for efficency)
  VENDORS_DATA = CSV.read("./support/vendors.csv")

  def initialize(vendor_hash)
    @vendor_id = vendor_hash[:vendor_id].to_i
    @vendor_name = vendor_hash[:vendor_name]
    @num_employees = vendor_hash[:num_employees].to_i
    @market_id = vendor_hash[:market_id].to_i
  end

  # self.all uses the constant VENDORS_DATA to populate a hash. That hash is then used to create objects that are then stored in the sales array (local variable). It is that array that is returned anytime self.all is called.
  def self.all
    vendors = []
    VENDORS_DATA.length.times do |x|
      vendor_hash = {vendor_id: VENDORS_DATA[x][0], vendor_name: VENDORS_DATA[x][1], num_employees: VENDORS_DATA[x][2], market_id: VENDORS_DATA[x][3]}
      vendors << FarMar::Vendor.new(vendor_hash)
    end
    return vendors
  end

  # self.by_market will return a collection of vendors for the provided market_id. Because it's calling into the FarMar::Market.find class method, it will raise an ArgumentError if the market_id does not exist (instead of returning an empty array).
  def self.by_market(market_id)
    market = FarMar::Market.find(market_id)
    return market.vendors
  end

 # self.find returns the object associated with the id or raises an ArgumentError if the id cannot be found
  def self.find(id)
    vendors = self.all
    vendor = nil
    vendors.length.times do |x|
      if vendors[x].vendor_id == id
        vendor = vendors[x]
      end
    end
    if vendor.nil?
      raise ArgumentError.new("This id cannot be found")
    else
      return vendor
    end
  end

  def market
    return FarMar::Market.find(self.market_id)
  end

  def products
    return FarMar::Product.by_vendor(self.vendor_id)
  end

  # sales returns a collection of sales objects for the vendor id associated with a vendor object calling this method. It will return an empty array if no sales have occured for that vendor.
  def sales
    sale_collection = []
    sales = FarMar::Sale.all
      sales.length.times do |x|
        if sales[x].vendor_id == self.vendor_id
          sale_collection << sales[x]
        end
      end
    return sale_collection
  end

  # revenue returns the amount of revenue in cents accumulated by vendor id associated with the object calling this method. It will return 0 (for no revenue) if no sales have occured for that vendor.
  def revenue
    revenue = 0
    sales = FarMar::Sale.all
    sales.length.times do |x|
      if sales[x].vendor_id == self.vendor_id
        revenue += sales[x].amount
      end
    end
    return revenue
  end

end
