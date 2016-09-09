# Sale Class

require_relative '../far_mar'

class FarMar::Sale
  attr_reader :sale_id, :amount, :purchase_time, :vendor_id, :product_id

  SALE_CSV_FILE = "./support/sales.csv"

  def initialize(sale_hash)
    @sale_id = sale_hash[:sale_id].to_i
    @amount = sale_hash[:amount].to_i
    @purchase_time = DateTime.strptime(sale_hash[:purchase_time], "%F %T %z")
    @vendor_id = sale_hash[:vendor_id].to_i
    @product_id = sale_hash[:product_id].to_i
  end

  # self.all opens up the associated csv file (constant) and populates a hash. That hash is then used to create objects that are then stored in an array (local variable). It is that array that is returned anytime self.all is called.
  def self.all
    sales = []
    CSV.open(SALE_CSV_FILE, "r").each do |line|
      sales_hash = {sale_id: line[0], amount: line[1], purchase_time: line[2], vendor_id: line[3], product_id: line[4]}
      sales << FarMar::Sale.new(sales_hash)
    end
    return sales
  end

 # self.find returns the object associated with the id or raises an ArgumentError if the id cannot be found
  def self.find(id)
    sales = self.all
    sale = nil
    sales.length.times do |x|
      if sales[x].sale_id.to_i == id
        sale = sales[x]
      end
    end
    if sale.nil?
      raise ArgumentError.new("This id cannot be found")
    else
      return sale
    end
  end

# self.between has heavy dependencies on the correct format of the DateTime data in each object's purchase_time attribute.
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
