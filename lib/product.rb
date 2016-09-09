# Product Class

require_relative '../far_mar'

class FarMar::Product
  attr_reader :product_id, :product_name, :vendor_id

  # Reading in the associated csv file for this class and storing it in a constant (for efficency). 
  PRODUCTS_DATA = CSV.read("./support/products.csv")

  def initialize(product_hash)
    @product_id = product_hash[:product_id].to_i
    @product_name = product_hash[:product_name]
    @vendor_id = product_hash[:vendor_id].to_i
  end

  # self.all uses the constant PRODUCTS_DATA to populate a hash. That hash is then used to create objects that are then stored in the sales array (local variable). It is that array that is returned anytime self.all is called.
  def self.all
    products = []
    PRODUCTS_DATA.each do |product|
      products_hash = {product_id: product[0], product_name: product[1], vendor_id: product[2]}
      products << FarMar::Product.new(products_hash)
    end
    return products
  end

 # self.find returns the object associated with the id or raises an ArgumentError if the id cannot be found
  def self.find(id)
    products = self.all
    product_obj = nil
    products.each do |product|
      if product.product_id.to_i == id
        product_obj = product
      end
    end
    if product_obj.nil?
      raise ArgumentError.new("This id cannot be found")
    else
      return product_obj
    end
  end

  # self.by_vendor returns a collection of the associated products for a provided vendor id. It will return an empty array if no products are associated with the vendor id provided.
  def self.by_vendor(vendor_id)
    product_collection = []
    products = FarMar::Product.all
      products.each do |product|
        if product.vendor_id == vendor_id
          product_collection << product
        end
      end
    return product_collection
  end

  def vendor
    return FarMar::Vendor.find(self.vendor_id)
  end

  # sales returns a collection of sales objects for the product id associated with a product object calling this method. It will return an empty array if no sales have occured for that product.
  def sales
    sale_collection = []
    sales = FarMar::Sale.all
      sales.each do |sale|
        if sale.product_id == self.product_id
          sale_collection << sale
        end
      end
    return sale_collection
  end

  def number_of_sales
    return sales.length
  end

end
