require_relative 'spec_helper'

describe 'Testing Market Class' do

  it 'testing that the self.all method for the Market Class will return an Array' do
    expect ((FarMar::Market.all).class).must_equal(Array)
  end

  it 'testing to ensure that self.find returns an instance of the object where the value of the id field in the CSV matches the passed parameter' do
    expect (FarMar::Market.find(300).zip).must_equal("86323")
  end

  it 'testing to ensure that for a given market, we can get a collecton of FarMar::Vendor instances that are assocaited with the market by the market_id field' do
    market1 = FarMar::Market.find(299)
    expect (market1.vendors.length).must_equal(6)
  end

end
