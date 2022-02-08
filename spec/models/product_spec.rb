require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'should save when product has all 4 fields set or true' do
      @category = Category.new(name: 'Testing')
      @product = Product.new(name: 'Modular Shelf', price_cents: 4500, quantity: 5, category: @category)
      
      # expect(@product.valid?).to be true # this one line alone also passes test
      
      @product.valid?
      expect(@product.errors).not_to include("can't be blank")
    end
    
    it 'should not save product when name field is nil or missing' do
      @category = Category.new(name: 'Testing')
      @product = Product.new(name: nil, price_cents: 4500, quantity: 5, category: @category)
      
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages[0]).to include("can't be blank")
      
      #for below lines to work remove name: nil 
      #@product.valid?
      #expect(@product.errors[:name]).to include("can't be blank")
    end
    
    it 'should not save product when price field is nil or missing' do
      @category = Category.new(name: 'Testing')
      @product = Product.new(name: 'Modular Shelf', price_cents: nil, quantity: 5, category: @category)
      
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages.count).to be 3 # 3 because errors are that it cant be nil, integer and one more. 

      #for below lines to work remove price: nil 
      #@product.valid?
      #expect(@product.errors[:price]).to include("can't be blank")
    end
    
    it 'should not save product when quantity field is nil or missing' do
      @category = Category.new(name: 'Testing')
      @product = Product.new(name: 'Modular Shelf', price_cents: 4500, quantity: nil, category: @category)
      
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages[0]).to include("can't be blank")

      #for below lines to work remove quantity: nil 
      #@product.valid?
      #expect(@product.errors[:quantity]).to include("can't be blank")
    end
    
    it 'should not save product when category is missing or not selected' do
      @category = Category.new(name: 'Testing')
      @product = Product.new(name: 'Modular Shelf', price_cents: 4500, quantity: 5, category: nil)
      
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages[0]).to include("can't be blank")

      # for below lines to work remove quantity: nil 
      # @product.valid?
      # expect(@product.errors[:category]).to include("can't be blank")
    end

  end
end

# validates :name, presence: true,
# validates :price, presence: true,
# validates :quantity, presence: true
# validates : category, presence: true

#-----------------TIPS--------------------------------------------------------------------------------------
# Each example (it) is run in isolation of others. 
# Therefore each example will needs its own @category created and then @product initialized with that category

# Create an initial example that ensures that a product with all four fields set will indeed save successfully

# Have one example for each validation, and for each of these:
#     # Set all fields to a value but the validation field being tested to nil
#     # Test that the expect error is found within the .errors.full_messages array

# You should therefore have five examples defined given that you have the four validations above
# ------------------------------------------------------------------------------------------------------------

#it 'validates category' do
#@product  = Product.new(name: 'test', description: 'test', image: 'test', price_cents: 100, quantity: 100)

#expect(@product.category).to be_nil
#expect(@product).not_to be_valid
#end


# it 'should save when product has all 4 fields set or true' do
#   @category = Category.new(name: 'Testing')
#   @product = Product.new(name: 'Modular Shelf', price_cents: 4500, quantity: 5, category: @category)
#   @product.name = 'Modular Shelf'
#   @product.price = nil
#   @product.quantity = 5
#   @product.category = @category
  
#   expect(@product.valid?).to be false
#   expect(@product.errors.full_messages.count).to be 3
# end

# it 'should not save product when name field is nil or missing' do
#   @category = Category.new(name: 'Testing')
#   @product = Product.new(price_cents: 4500, quantity: 5, category: @category)
#   @product.valid?

#   expect(@product.errors[:name]).to include("can't be blank")
# end