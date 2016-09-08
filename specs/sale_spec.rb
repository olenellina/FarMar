require_relative 'spec_helper'

describe 'Testing Sale Class' do

it 'testing that the self.all method for the Sale Class will return an Array' do
    expect ((FarMar::Sale.all).class).must_equal(Array)
  end

  it 'testing to ensure that self.find does not return nil' do
    expect (FarMar::Sale.find(300)).wont_be_nil
  end

  it 'testing to ensure the correct vendor instance is returned for a provided vendor using the FarMar::Sale vendor_id field' do
    sale1 = FarMar::Sale.find(3311)
    expect (sale1.vendor.vendor_id).must_equal(735)
  end

  it 'testing to ensure the correct product instance is returned for a provided sale using the FarMar::Sale product_id field' do
    sale2 = FarMar::Sale.find(4254)
    expect (sale2.product.product_id).must_equal(2921)
  end

  it 'testing to ensure that a collection of FarMar::Sale objects is returned where the purchase time is between two times given as arugments' do
    expect FarMar::Sale.between(DateTime.new(2001,2,3,4,5,6), DateTime.new(2014,2,3,4,5,6)).wont_be_nil
  end

end
