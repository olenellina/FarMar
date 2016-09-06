require_relative 'spec_helper'
require_relative '../lib/market'

describe 'Testing Market Class' do
  it 'testing to ensure markets.csv is accessible to Market Class' do
    expect (market1 = FarMar::Market.new).class.must_equal(FarMar::Market)
  end
end
