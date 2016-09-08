require_relative '../far_mar'

class FarMar::Product
  attr_reader :product_id, :product_name, :vendor_id

  def initialize(product_hash)
    @product_id = product_hash[:product_id].to_i
    @product_name = product_hash[:product_name]
    @vendor_id = product_hash[:vendor_id].to_i
  end

  def self.all
    products = []
    CSV.open("./support/products.csv", "r").each do |line|
      products_hash = {product_id: line[0], product_name: line[1], vendor_id: line[2]}
      products << FarMar::Product.new(products_hash)
    end
    return products
  end

  def self.find(id)
    products = self.all
    products.length.times do |x|
      if products[x].product_id.to_i == id
        return products[x]
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
