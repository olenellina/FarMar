require_relative '../far_mar'

class FarMar::Vendor
  def initialize
    File.open("./support/vendors.csv", 'r')
  end
end
