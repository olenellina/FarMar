require 'csv'
require_relative '../far_mar'
require 'awesome_print'
require_relative './market'
require_relative './product'
require_relative './sale'

class FarMar::Vendor
  attr_reader :vendors, :vendor_id, :vendor_name, :num_employees, :market_id
  @@vendors = []

  def initialize(vendor_hash)
    @vendor_id = vendor_hash[:vendor_id].to_i
    @vendor_name = vendor_hash[:vendor_name]
    @num_employees = vendor_hash[:num_employees].to_i
    @market_id = vendor_hash[:market_id].to_i

    @@vendors << self
  end


  def self.csv_processor(csvfile)
    CSV.open(csvfile, "r").each do |line|
      vendor_hash = {vendor_id: line[0], vendor_name: line[1], num_employees: line[2], market_id: line[3]}
      FarMar::Vendor.new(vendor_hash)
    end
  end

  def self.all
    return @@vendors
  end

  def self.find(id)
    @@vendors.length.times do |x|
      if @@vendors[x].vendor_id == id
        return @@vendors[x]
      end
    end
  end

  def market
    return FarMar::Market.find(self.market_id)
  end

  def products
    product_collection = []
    products = FarMar::Product.all
      products.length.times do |x|
        if products[x].vendor_id == self.vendor_id
          product_collection << products[x]
        end
      end
    return product_collection
  end

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


# products: returns a collection of FarMar::Product instances that are associated by the FarMar::Product vendor_id field.
# sales: returns a collection of FarMar::Sale instances that are associated by the vendor_id field.
# revenue: returns the the sum of all of the vendor's sales (in cents)
# self.by_market(market_id): returns all of the vendors with the given market_id

# FarMar::Vendor.csv_processor("./support/vendors.csv")
# FarMar::Market.csv_processor("./support/markets.csv")
# FarMar::Vendor.all
# puts FarMar::Vendor.find(1213)
#
# vendor1 = FarMar::Vendor.find(299)
# puts vendor1.market
