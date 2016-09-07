require 'csv'
require_relative '../far_mar'
require 'awesome_print'

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

# market: returns the FarMar::Market instance that is associated with this vendor using the FarMar::Vendor market_id field
# products: returns a collection of FarMar::Product instances that are associated by the FarMar::Product vendor_id field.
# sales: returns a collection of FarMar::Sale instances that are associated by the vendor_id field.
# revenue: returns the the sum of all of the vendor's sales (in cents)
# self.by_market(market_id): returns all of the vendors with the given market_id

end

# FarMar::Vendor.csv_processor("./support/vendors.csv")
# FarMar::Vendor.all
# puts FarMar::Vendor.find(1213)
