require 'csv'
require_relative '../far_mar'
require 'awesome_print'

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
      vendor_hash = {product_id: line[0], product_name: line[1], vendor_id: line[3]}
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

end

# FarMar::Product.csv_processor("./support/products.csv")
# FarMar::Product.all
# puts FarMar::Product.find(2079)
