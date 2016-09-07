require 'csv'
require_relative '../far_mar'
require 'awesome_print'

class FarMar::Sale
  attr_reader :sales, :sale_id, :amount, :purchase_time, :vendor_id, :product_id
  @@sales = []

  def initialize(sale_hash)
    @sale_id = sale_hash[:sale_id].to_i
    @amount = sale_hash[:amount].to_i
    @purchase_time = sale_hash[:purchase_time]
    @vendor_id = sale_hash[:vendor_id].to_i
    @product_id = sale_hash[:product_id].to_i

    @@sales << self
  end


  def self.csv_processor(csvfile)
    CSV.open(csvfile, "r").each do |line|
      vendor_hash = {sale_id: line[0], amount: line[1], purchase_time: line[2], vendor_id: line[3], product_id: line[4]}
      FarMar::Sale.new(vendor_hash)
    end
  end

  def self.all
    return @@sales
  end

  def self.find(id)
    @@sales.length.times do |x|
      if @@sales[x].sale_id.to_i == id
        return @@sales[x]
      end
    end
  end

end
