module GroceryList
  module Categories
    class ProductsController < ApplicationController
      def index
        @category = ProductManagement::Category.find(params[:category_id])
        @products = ProductManagement::Product.where(category_id: params[:category_id])
      end
    end
  end
end
