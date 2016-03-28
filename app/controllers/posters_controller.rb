class PostersController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :find_poster, only: [:show, :edit, :update, :destroy]

  def new
    @poster = Poster.new
    respond_to do |format|
      format.js { render 'admin/posters/new.js.erb' }
    end
  end

  def show
    respond_to do |format|
      format.js { render 'admin/posters/show.js.erb' }
    end
  end

  def edit
    respond_to do |format|
      format.js   { render 'admin/posters/edit.js.erb' }
    end
  end

  def create
    @poster = Poster.new(poster_params)
    respond_to do |format|
      if @poster.save
        format.js   { render 'admin/posters/show.js.erb' }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.js   { render 'admin/posters/update.js.erb' }           
      end
    end
  end

  def destroy
    respond_to do |format|
      if @poster.destroy
        format.js   { render 'admin/posters/destroy.js.erb' }
      end
    end
  end

  private
    def find_poster
      @poster = Poster.find(params[:id])
    end

    def poster_params
      params.require(:poster).permit(:title, :text)
    end
end
