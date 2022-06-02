require 'rails_helper'

RSpec.describe Food, type: :model do
  #https://relishapp.com/rspec/rspec-core/docs/subject/explicit-subject
  subject(:food){
    category = Category.new(name: "test")
    Food.new(
      name: 'Nasi Uduk',
      description: 'Betawi style steamed rice cooked in coconut milk. Delicious!',
      price: 15000.0,
      category: category
    )
  }
    
  it 'is valid with a name and a description' do
    
    food 

    expect(food).to be_valid
  end

  it 'is invalid without a name' do
    food.name = nil

    food.valid?

    expect(food.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    category = Category.new(name: "test")
    
    food1 = Food.create(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0,
      category: category
    )
    
    food2 = Food.new(
      name: "Nasi Uduk",
      description: "Just with a different description.",
      price: 10000.0,
      category: category
    )

    food2.valid?
    
    expect(food2.errors[:name]).to include("has already been taken")
  end

  describe 'self#by_letter' do
    it "should return a sorted array of results that match" do
      category = Category.new(name: "test")
      food1 = Food.create(
        name: "Nasi Uduk",
        description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
        price: 10000.0,
        category: category
      )

      food2 = Food.create(
        name: "Kerak Telor",
        description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
        price: 8000.0,
        category: category
      )

      food3 = Food.create(
        name: "Nasi Semur Jengkol",
        description: "Based on dongfruit, this menu promises a unique and delicious taste with a small hint of bitterness.",
        price: 8000.0,
        category: category
      )

      expect(Food.by_letter("N")).to eq([food3, food1])
    end
  end
end

