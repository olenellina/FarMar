require_relative '../far_mar'
require 'date'
class FarMar::Sale
  attr_reader :sale_id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize(sale_hash)
    @sale_id = sale_hash[:sale_id].to_i
    @amount = sale_hash[:amount].to_i
    @purchase_time = DateTime.strptime(sale_hash[:purchase_time], "%F %T %z")
    # 2013-11-07 04:34:56 -0800
    @vendor_id = sale_hash[:vendor_id].to_i
    @product_id = sale_hash[:product_id].to_i
  end

  def self.all
    sales = []
    CSV.open("./support/sales.csv", "r").each do |line|
      sales_hash = {sale_id: line[0], amount: line[1], purchase_time: line[2], vendor_id: line[3], product_id: line[4]}
      sales << FarMar::Sale.new(sales_hash)
    end
    return sales
  end

  def self.find(id)
    sales = self.all
    sales.length.times do |x|
      if sales[x].sale_id.to_i == id
        return sales[x]
      end
    end
  end

  def self.between(beginning_time, end_time)
    sale_collection = []
    sales = FarMar::Sale.all
      sales.length.times do |x|
        if sales[x].purchase_time >= beginning_time && sales[x].purchase_time <= end_time
          sale_collection << sales[x]
        end
      end
    return sale_collection
  end

  def vendor
    return FarMar::Vendor.find(self.vendor_id)
  end

  def product
    return FarMar::Product.find(self.product_id)
  end

end
