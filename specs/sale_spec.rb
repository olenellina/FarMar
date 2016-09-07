require_relative 'spec_helper'
require_relative '../lib/sale'


describe 'Testing Sale Class' do
  FarMar::Sale.csv_processor("./support/sales.csv")

  it 'testing that the self.all method for the Sale Class will return an Array' do
    expect ((FarMar::Sale.all).class).must_equal(Array)
  end

  # it 'testing to ensure that self.all returns an array equal to the length of the csv file' do
  #   filename = "./support/sales.csv"
  #   line_count = %x{sed -n '=' #{filename} | wc -l}.to_i
  #   expect ((FarMar::Sale.all).length).must_equal(line_count)
  # end

  it 'testing to ensure that self.find does not return nil' do
    expect (FarMar::Sale.find(300)).wont_be_nil
  end
end
