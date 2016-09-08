require_relative '../far_mar'

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

  def self.by_vendor(vendor_id)
    product_collection = []
    products = FarMar::Product.all
      products.length.times do |x|
        if products[x].vendor_id == vendor_id
          product_collection << products[x]
        end
      end
    return product_collection
  end

  def vendor
    return FarMar::Vendor.find(self.vendor_id)
  end

  def sales
    sale_collection = []
    sales = FarMar::Sale.all
      sales.length.times do |x|
        if sales[x].product_id == self.product_id
          sale_collection << sales[x]
        end
      end
    return sale_collection
  end

  def number_of_sales
    return sales.length
  end

end
