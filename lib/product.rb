require_relative '../far_mar'

class FarMar::Product
  def initialize
    File.open("./support/products.csv", 'r')
  end
end
