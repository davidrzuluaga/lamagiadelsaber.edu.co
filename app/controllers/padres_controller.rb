class PadresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit]

  def index
    @boletines = Padre.where(category: "boletines").order(:created_at).limit(3)
    @infoutil = Padre.where(category: "infoutil").order(:created_at).limit(3)
  end

  def infoutil
    @infoutil = Padre.where(category: "infoutil").order(:created_at)
  end

  def boletines
    @boletines = Padre.where(category: "boletines").order(:created_at)    
  end

  def show
    @info = Padre.find(params[:id])
  end

  def new
    @padre = Padre.new
  end
  
  def create
    @padre = Padre.new(padre_params)
    if @padre.save
      flash[:success] = "Creado con Éxito!"
      redirect_to publicaciones_path
    else
     render :new 
    end
  end

  def edit
    @padre = Padre.find(params[:id])
  end

  def update
    @padre = Padre.find(params[:id])
    if @padre.update(padre_params)
      flash[:success] = "Modificado con Éxito!"
      redirect_to publicaciones_path
    else
      render :edit
    end
  end

  def destroy
    padre = Padre.find(params[:id])
    padre.destroy
    flash[:success] = "Eliminado con Éxito!"
    redirect_to publicaciones_path
  end

private
  
  def padre_params
    params.require(:padre).permit(:title, :body, :imgcover, :category, :pdflink)
  end
end
