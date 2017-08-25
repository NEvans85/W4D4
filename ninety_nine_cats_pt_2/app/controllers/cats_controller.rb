class CatsController < ApplicationController
  before_action :login_check, only: [:create, :new, :edit, :update]
  before_action :owner_check

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:user_id, :age, :birth_date, :color, :description, :name, :sex)
  end

  def login_check
    unless logged_in?
      flash[:errors] = ["You must be logged in to create a cat"]
      redirect_to cats_url
    end
  end

  def owner_check
    current_user.cats.any? { |cat| cat.id = params[:id] }
  end
end
