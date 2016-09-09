#Sale Class Spec

require_relative 'spec_helper'

describe 'Testing Sale Class' do

  it 'testing that self.all method for Sale Class returns an array equal to the length of the csv file' do
    filename = "./support/sales.csv"
    line_count = %x{sed -n '=' #{filename} | wc -l}.to_i
    expect ((FarMar::Sale.all).length).must_equal(line_count)
  end

  it 'testing that the self.all method for the Sale Class will return an Array' do
    expect ((FarMar::Sale.all).class).must_equal(Array)
  end

  it 'testing to ensure that self.find does not return nil if the sale id exists' do
    expect (FarMar::Sale.all.sample).wont_be_nil
  end

  it 'testing to ensure that an ArgumentError is raised if the sale id does not exist' do
  expect(proc {FarMar::Sale.find(13000)}).must_raise ArgumentError
  end

  it 'testing to ensure the correct vendor instance is returned for a provided vendor using the FarMar::Sale vendor_id field' do
    sale1 = FarMar::Sale.find(3311)
    expect (sale1.vendor.id).must_equal(735)
  end

  it 'testing to ensure the correct product instance is returned for a provided sale using the FarMar::Sale product_id field' do
    sale2 = FarMar::Sale.find(4254)
    expect (sale2.product.id).must_equal(2921)
  end

  # Lots of extra tests for the between method, as this was the buggiest area of my code
  it 'testing to ensure that a collection of FarMar::Sale objects is returned where the purchase time is between two times given as arugments' do
    expect FarMar::Sale.between(DateTime.new(2001,2,3,4,5,6), DateTime.new(2014,2,3,4,5,6)).wont_be_nil
  end

  it 'testing to ensure that an array of length 0 is returned for a DateTime parameters that our outside of the range provided in the csv file' do
    expect (FarMar::Sale.between(DateTime.new(2015,2,3,4,5,6), DateTime.new(2016,2,3,4,5,6))).length.must_equal(0)
  end

  it 'testing to ensure that nil is not returned when a sample of purchase_time for FarMar::Sale objects are provided as arguments' do
    expect FarMar::Sale.between(FarMar::Sale.all.sample.purchase_time, FarMar::Sale.all.sample.purchase_time).wont_be_nil
  end

  it 'testing to ensure that an array is returned for a collection of FarMar::Sale objects where the purchase time is a valid range' do
    expect (FarMar::Sale.between(DateTime.new(2001,2,3,4,5,6), DateTime.new(2014,2,3,4,5,6))).class.must_equal(Array)
  end

  it 'testing to ensure that an array of length > 0 is returned for a collection of FarMar::Sale objects where the purchase time is a valid range' do
    expect FarMar::Sale.between(DateTime.new(2001,2,3,4,5,6), DateTime.new(2014,2,3,4,5,6)).wont_be_empty
  end

  it 'testing to ensure that the correct sales time is returned for a given sales id' do
    expect (FarMar::Sale.find(1).purchase_time.to_s).must_equal("2013-11-07T04:34:56-08:00")
  end

end
