require_relative 'spec_helper'
require_relative '../lib/vendor'


describe 'Testing Vendor Class' do
  FarMar::Vendor.csv_processor("./support/vendors.csv")

  it 'testing that the self.all method for the Vendor Class will return an Array' do
    expect ((FarMar::Vendor.all).class).must_equal(Array)
  end

  it 'testing to ensure that self.all returns an array equal to the length of the csv file' do
    filename = "./support/vendors.csv"
    line_count = %x{sed -n '=' #{filename} | wc -l}.to_i
    expect ((FarMar::Vendor.all).length).must_equal(line_count)
  end

  it 'testing to ensure that self.find does not return nil' do
    expect (FarMar::Vendor.find(300)).wont_be_nil
  end
end
