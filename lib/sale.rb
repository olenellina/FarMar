# Sale Class

require_relative '../far_mar'

class FarMar::Sale
  attr_reader :sale_id, :amount, :purchase_time, :vendor_id, :product_id

  # Reading in the associated csv file for this class and storing it in a constant (for efficency)
  SALES_DATA = CSV.read("./support/sales.csv")

  def initialize(sale_hash)
    @sale_id = sale_hash[:sale_id].to_i
    @amount = sale_hash[:amount].to_i
    @purchase_time = DateTime.strptime(sale_hash[:purchase_time], "%F %T %z")
    @vendor_id = sale_hash[:vendor_id].to_i
    @product_id = sale_hash[:product_id].to_i
  end

  # self.all uses the constant SALES_DATA to populate a hash. That hash is then used to create objects that are then stored in the sales array (local variable). It is that array that is returned anytime self.all is called.
  def self.all
    sales = []
    SALES_DATA.each do |sale|
      sales_hash = {sale_id: sale[0], amount: sale[1], purchase_time: sale[2], vendor_id: sale[3], product_id: sale[4]}
      sales << FarMar::Sale.new(sales_hash)
    end
    return sales
  end

 # self.find returns the object associated with the id or raises an ArgumentError if the id cannot be found
  def self.find(id)
    sales = self.all
    sale_obj = nil
    sales.each do |sale|
      if sale.sale_id.to_i == id
        sale_obj = sale
      end
    end
    if sale_obj.nil?
      raise ArgumentError.new("This id cannot be found")
    else
      return sale_obj
    end
  end

# self.between has heavy dependencies on the correct format of the DateTime data in each object's purchase_time attribute.
  def self.between(beginning_time, end_time)
    sale_collection = []
    sales = FarMar::Sale.all
      sales.each do |sale|
        if sale.purchase_time >= beginning_time && sale.purchase_time <= end_time
          sale_collection << sale
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
