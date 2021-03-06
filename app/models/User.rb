class User

  attr_reader :name

  @@all_users = []

  def initialize(name)
    @name = name
    self.class.all << self
  end

  def self.all
    @@all_users
  end

  def recipes
    recipes_helper.map do |recipe_card|
      recipe_card.recipe
    end
  end

  def add_recipe_card(recipe, date, rating)
    RecipeCard.new(self, recipe, date, rating)
  end

  def declare_allergen(ingredient)
    Allergen.new(self, ingredient)
  end

  def allergens
    Allergen.all.select do |allergen|
      allergen.user == self
    end
  end

  def top_three_recipes
    top_recipe_helper[0..2].collect {|recipe_card| recipe_card.recipe}
  end

  def most_recent_recipe
    recipes_helper.sort { |a, b| b.date.to_i <=> a.date.to_i }.shift(3)
  end


  private

  def recipes_helper
    RecipeCard.all.select do |recipe_card|
      recipe_card.user == self
    end
  end

  def top_recipe_helper
    recipes_helper.sort {|a, b| b.rating <=> a.rating}
  end

end
