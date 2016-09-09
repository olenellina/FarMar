#Product Class Spec

require_relative 'spec_helper'

describe 'Testing Product Class' do

  it 'testing that self.all method for Product Class returns an array equal to the length of the csv file' do
    filename = "./support/products.csv"
    line_count = %x{sed -n '=' #{filename} | wc -l}.to_i
    expect ((FarMar::Product.all).length).must_equal(line_count)
  end

  it 'testing that the self.all method for Product Class will return an Array' do
    expect ((FarMar::Product.all).class).must_equal(Array)
  end

  it 'testing to ensure that self.find does not return nil if the product id exists' do
    expect (FarMar::Product.all.sample).wont_be_nil
  end

  it 'testing to ensure that an ArgumentError is raised if the product id does not exist' do
  expect(proc {FarMar::Product.find(13000)}).must_raise ArgumentError
  end

  it 'testing to ensure the correct vendor instance is returned for a provided vendor using the FarMar::Product vendor_id field' do
    product1 = FarMar::Product.find(969)
    expect (product1.vendor.vendor_id).must_equal(313)
  end

  it 'testing to ensure for a given FarMar::Sale product id, we can get back a collection of the associated sale instances' do
    product2 = FarMar::Product.find(2185)
    expect (product2.sales.length).must_equal(8)
  end

  it 'testing to ensure that an empty array is returned for a given product id that has not had an associated sale occur' do
    product3 = FarMar::Product.find(3)
    expect (product3.sales.length).must_equal(0)
  end

  it 'testing to ensure for a given product id, we can get back the number of times that product has been sold' do
    product3 = FarMar::Product.find(2201)
    expect (product3.number_of_sales).must_equal(4)
  end

  it 'testing to ensure that 0 is returned for a given product id that has not had an associated sale occur' do
    product3 = FarMar::Product.find(3)
    expect (product3.number_of_sales).must_equal(0)
  end

  it 'testing to ensure for a given vendor id, we can get a list of products for that vendor id' do
    expect (FarMar::Product.by_vendor(860).length).must_equal(5)
  end

  it 'testing to ensure for vendor id that does not exist, an empty array of products is returned' do
    expect (FarMar::Product.by_vendor(13000).length).must_equal(0)
  end

  it 'testing to ensure for a sample vendor id, we do not get back nil products' do
    expect (FarMar::Product.by_vendor(FarMar::Product.all.sample.vendor_id).length).wont_be_nil
  end

end
