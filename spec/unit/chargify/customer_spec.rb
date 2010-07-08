require 'spec_helper'

describe Chargify::Customer do

  before(:all) do
    Chargify::Config.setup do |config|
      config[:api_key] = 'OU812'
      config[:subdomain] = 'pengwynn'
    end
  end

  describe '.find' do

    it 'should pass to Chargified::Customer.all' do
      Chargify::Customer.should_receive(:all)
      Chargify::Customer.find(:all)
    end

    it "should be able to be found by a <chargify_id>" do
      stub_get "https://OU812:x@pengwynn.chargify.com/customers/16.json", "customer.json"
      customer = Chargify::Customer.find(16)
      customer.success?.should == true
    end

    it "should return an empty Hash with success? set to false" do
      stub_get "https://OU812:x@pengwynn.chargify.com/customers/16.json", "", 404
      customer = Chargify::Customer.find(16)
      customer.success?.should == false
    end

  end


  describe '.lookup' do

    before do
      stub_get "https://OU812:x@pengwynn.chargify.com/customers/lookup.json?reference=bradleyjoyce", "customer.json"
    end

    it "should be able to be found by a <reference_id>" do
      customer = Chargify::Customer.lookup("bradleyjoyce")
      customer.success?.should == true
    end

  end


  describe ".all" do

    before do
      stub_get "https://OU812:x@pengwynn.chargify.com/customers.json", "customers.json"
    end

    it "should return a list of customers" do
      customers = Chargify::Customer.all
      customers.size.should == 1
      customers.first.reference.should == 'bradleyjoyce'
      customers.first.organization.should == 'Squeejee'
    end

  end

  describe '.create' do

    before do
      stub_post "https://OU812:x@pengwynn.chargify.com/customers.json", "new_customer.json"
    end

    it "should create a new customer" do
      info = {
        :first_name   => "Wynn",
        :last_name    => "Netherland",
        :email        => "wynn@example.com"
      }
      customer = Chargify::Customer.create(info)
      customer.first_name.should == "Wynn"
    end

  end

  describe '.update' do

    before do
      stub_put "https://OU812:x@pengwynn.chargify.com/customers/16.json", "new_customer.json"
    end

    it "should update a customer" do
      info = {
        :id           => 16,
        :first_name   => "Wynn",
        :last_name    => "Netherland",
        :email        => "wynn@example.com"
      }
      customer = Chargify::Customer.update(info)
      customer.first_name.should == "Wynn"
    end

  end

end
