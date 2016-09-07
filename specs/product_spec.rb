require_relative 'spec_helper'
require_relative '../lib/product'


describe 'Testing Product Class' do
  FarMar::Product.csv_processor("./support/products.csv")

  it 'testing that the self.all method for Product Class will return an Array' do
    expect ((FarMar::Product.all).class).must_equal(Array)
  end

  it 'testing that self.all method for Product Class returns an array equal to the length of the csv file' do
    filename = "./support/products.csv"
    line_count = %x{sed -n '=' #{filename} | wc -l}.to_i
    expect ((FarMar::Product.all).length).must_equal(line_count)
  end

  it 'testing to ensure that self.find does not return nil' do
    expect (FarMar::Product.find(300)).wont_be_nil
  end
end
