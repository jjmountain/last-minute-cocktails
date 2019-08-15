# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts "Destroying Cocktails"

Cocktail.destroy_all

puts "destroying ingredients!"

Ingredient.destroy_all

puts 'getting ingredients from DB'

ingredients_list = URI.parse('http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read

ingredients_json = JSON.parse(ingredients_list)

ingredients_json['drinks'].each do | drink |
    Ingredient.create(name: drink['strIngredient1'])
end

puts 'created ingredients!'

alphabet_array = Array %w(a b c d e f g h i k l m n o p q r s t v w y z)

alphabet_array.each do |letter|
  puts "creating cocktails and doses for letter #{letter}"
  cocktail = URI.parse("https://www.thecocktaildb.com/api/json/v1/1/search.php?f=#{letter}").read
  cocktail_json = JSON.parse(cocktail)
    cocktail_json['drinks'].each do | cocktail |
      ## create cocktail
      new_cocktail = Cocktail.create(name: cocktail['strDrink'], thumbnail: cocktail['strDrinkThumb'])

      ## look at each ingredient field from 1-15
      nums = 1..15
      cocktails_array = nums.to_a
      ingredient_keys = cocktails_array.map { |num| "strIngredient#{num}"}
      dose_keys = cocktails_array.map { |num| "strMeasure#{num}"}

      ## if the ingredient field has something in it, create a dose which has this ingredient and the cocktail
      ingredient_keys.each_with_index do | ingredient_key, index |
        unless cocktail[ingredient_key].nil? || cocktail[ingredient_key].empty?
          Dose.create(
            ingredient: Ingredient.find_by(name: cocktail[ingredient_key]),
            cocktail: new_cocktail,
            description: cocktail[dose_keys[index + 1]])
        end
      end
    end
  puts "successfully created cocktails and doses for letter #{letter}"
end