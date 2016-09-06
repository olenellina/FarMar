# You should be able to create instances of these classes that know about their associated data file.

require_relative '../far_mar'

class FarMar::Market
  def initialize
    File.open("./support/markets.csv", 'r')
  end
end
