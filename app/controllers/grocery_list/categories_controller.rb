module GroceryList
  class CategoriesController < ApplicationController
    def index
      @categories = ProductManagement::Category.all
    end
  end
end
