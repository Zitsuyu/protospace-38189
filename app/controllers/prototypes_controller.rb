class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototypes = Prototype.new
  end

  def create
    @prototypes = Prototype.create(prototype_params)
    if @prototypes.save
      redirect_to "/"
    else
      render :new
    end
  end

  def show
    @prototypes = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototypes.comments.includes(:user)
  end

  def edit
    @prototypes = Prototype.find(params[:id])
    unless @prototypes.user.id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    @prototypes = Prototype.find(params[:id])
    @prototypes.update(prototype_params)
    if @prototypes.update(prototype_params)
      redirect_to prototype_path(@prototypes.id)
    else 
      render :edit
    end

  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to "/"
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end

