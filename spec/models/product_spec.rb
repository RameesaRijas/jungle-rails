require 'rails_helper'
RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before do
      @product = Product.new
      @category = Category.new name: "Electronics"
    end

    it 'is creating successfully if no error is there' do
      @product_item = Product.new(name: 'Oven', price: 1349, quantity: 3, category: @category)
      @product_item.save!
      expect(@product_item).to be_persisted
    end

    it 'is invalid without a name' do
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include('can\'t be blank')
    end

    it 'is invalid without a price' do
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include('can\'t be blank')
    end

    it 'is invalid without quantity' do
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
    end

    it 'is invalid without category' do
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include('can\'t be blank')
    end
  end
end