class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :update, :destroy]
    
    def index
        @categories = Category.all.page(params[:page]).per(5)
        render json: @categories
    end

    def show
        render json: @categories
    end

    def create
        @category = Category.new(category_params)

        if @category.save
            render json: @category, notice: 'Category was successfully created.'
        else
            render json: @category, status: :unprocessable_entity 
        end
    end

    def update
        if @category.update(category_params)
            render json: @category, notice: 'Category was successfully updated.'
        else
            render json: @category, status: :unprocessable_entity 
        end
    end

    def destroy
        @category.destroy
        head :no_content
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
end
