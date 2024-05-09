class SubcategoriesController < ApplicationController
    before_action :set_category
    before_action :set_subcategory, only: [:show, :update, :destroy]

    def index
        @subcategories = @category.subcategories.page(params[:page]).per(5)
        render json: @subcategories
    end

    def show
        render json: @subcategories
    end

    def create
        byebug
        @subcategory = @category.subcategories.new(subcategory_params)

        if @subcategory.save
            render json: @subcategory, notice: 'SubCategory was successfully created.'
        else
            renser json: @subcategory.errors, status: :unprocessable_entity
        end
    end

    def update
        if @subcategory.update!(subcategory_params)
            render json: @subcategory, notice: 'SubCategory was successfully updated.'
        else
            render json: @subcategory.errors, stutus: :unprocessable_entity
        end
    end

    def destroy
        @subcategories.destroy
        head :no_content
    end

    private

    def set_category
        @category = Category.find(params[:category_id])
    end

    def set_subcategory
        @subcategories = @category.subcategories.find(params[:id])
    end

    def subcategory_params
        params.require(:subcategory).permit(:subcategory_name, :category_id)
    end
end
