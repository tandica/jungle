class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_BASIC_AUTH_USER'], password: ENV['HTTP_BASIC_AUTH_PASS']
  
  def index
    @categories = Category.all
  end

  def new
    @categories = Product.new
  end

  def create
    @category = Category.new(product_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def categories_params
    params.require(:category).permit(:name)
  end
end
