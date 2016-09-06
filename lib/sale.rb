require_relative '../far_mar'

class FarMar::Sale
  def initialize
    File.open("./support/sales.csv", 'r')
  end
end
