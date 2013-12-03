class CategoriesController < ApplicationController
   # For the view/categories/index.html.erb page
    def index
        @categories = Category.all
    end

    # For the view/categories/show.html.erb
    def show
      @category = Category.find(params[:id])
    end

    def new
        @category = Category.new
    end

    # What to show when you edit the category.
    def edit
        @category = Category.find(params[:id])
    end

    # What to do for creating new Categories.
    def create
        @category = Category.new(cat_params)
        
        if @category.save
          redirect_to admin_categories_url
        else
          render :new
        end
    end

    # When you edit/update the category, update the information
    def update
        @category = Category.find(params[:id])
        if @category.update_attributes(params[:category].permit!)
            redirect_to categories_url
        else
            render :edit
        end
    end

    # Destroy/delete the Category.
    def destroy
        Category.destroy(params[:id])
        redirect_to categories_url
    end


    private 

    def cat_params
      params.require(:category).permit(:name)
    end

end