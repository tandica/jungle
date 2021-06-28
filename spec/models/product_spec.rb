require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valide when product saves successfully with four fields set" do
      @category = Category.create(name: 'laptop')
      @product = Product.new(name: "Alienware", price: 3000, quantity: 1, category: @category)
      expect(@product).to be_valid
    end

    it "is valid only when name is present" do
      @category = Category.create(name: 'laptop')
      @product = Product.new(name: "", price: 3000, quantity: 1, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql(["Name can't be blank"]) 
    end

    it "is valid only when price is present" do
      @category = Category.create(name: 'laptop')
      @product = Product.new(name: "Alienware", price: nil, quantity: 1, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql(["Price cents is not a number", "Price is not a number", "Price can't be blank"]) 
    end

    it "is valid only when quantity is present" do
      @category = Category.create(name: 'laptop')
      @product = Product.new(name: "Alienware", price: 3000, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql(["Quantity can't be blank"]) 
    end

    it "is valid only when category is present" do
      @category = Category.create(name: 'laptop')
      @product = Product.new(name: "Alienware", price: 3000, quantity: 1, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql(["Category can't be blank"]) 
    end
  end
end
