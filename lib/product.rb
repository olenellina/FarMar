require 'csv'
require_relative '../far_mar'
require 'awesome_print'
require_relative './market'
require_relative './vendor'

class FarMar::Product
  attr_reader :products, :product_id, :product_name, :vendor_id
  @@products = []

  def initialize(product_hash)
    @product_id = product_hash[:product_id].to_i
    @product_name = product_hash[:product_name]
    @vendor_id = product_hash[:vendor_id].to_i

    @@products << self
  end


  def self.csv_processor(csvfile)
    CSV.open(csvfile, "r").each do |line|
      vendor_hash = {product_id: line[0], product_name: line[1], vendor_id: line[2]}
      FarMar::Product.new(vendor_hash)
    end
  end

  def self.all
    return @@products
  end

  def self.find(id)
    @@products.length.times do |x|
      if @@products[x].product_id.to_i == id
        return @@products[x]
      end
    end
  end

  def vendor
    return FarMar::Vendor.find(self.vendor_id)
  end

end


# vendor: returns the FarMar::Vendor instance that is associated with this vendor using the FarMar::Product vendor_id field
# sales: returns a collection of FarMar::Sale instances that are associated using the FarMar::Sale product_id field.
# number_of_sales: returns the number of times this product has been sold.
# self.by_vendor(vendor_id): returns all of the products with the given vendor_id
