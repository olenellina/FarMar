require_relative 'spec_helper'
require_relative '../lib/market'


describe 'Testing Market Class' do
  FarMar::Market.csv_processor("./support/markets.csv")

  it 'testing that the self.all method for the Market Class will return an Array' do
    expect ((FarMar::Market.all).class).must_equal(Array)
  end

  it 'testing to ensure that self.all returns an array equal to the length of the csv file' do
    filename = "./support/markets.csv"
    line_count = %x{sed -n '=' #{filename} | wc -l}.to_i
    expect ((FarMar::Market.all).length).must_equal(line_count)
  end

  it 'testing to ensure that self.find does not return nil' do
    expect (FarMar::Market.find(300)).wont_be_nil
  end
end
