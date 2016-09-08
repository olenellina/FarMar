require_relative 'spec_helper'

describe 'Testing Vendor Class' do

  it 'testing that the self.all method for the Vendor Class will return an Array' do
    expect ((FarMar::Vendor.all).class).must_equal(Array)
  end

  it 'testing to ensure that self.find does not return nil' do
    expect (FarMar::Vendor.find(300)).wont_be_nil
  end

  it 'testing to ensure the correct market instance is returned for a provided vendor using the market_id field' do
    vendor1 = FarMar::Vendor.find(299)
    expect (vendor1.market.market_id).must_equal(55)
  end

  it 'testing to ensure for a given vendor id, we can get a list of products for that vendor id' do
    vendor2 = FarMar::Vendor.find(301)
    expect (vendor2.products.length).must_equal(4)
  end

  it 'testing to ensure for a given vendor id, we can get a list of associated sales for that vendor id' do
    vendor3 = FarMar::Vendor.find(366)
    expect (vendor3.sales.length).must_equal(7)
  end

  it 'testing to ensure for a given vendor id, we can get the associated total sales revenue' do
    vendor4 = FarMar::Vendor.find(400)
    expect (vendor4.revenue).must_equal(9368)
  end

  it 'testing to ensure for a given market id, we can get back a collection of associated vendors' do
    expect (FarMar::Vendor.by_market(415).length).must_equal(10)
  end

end
