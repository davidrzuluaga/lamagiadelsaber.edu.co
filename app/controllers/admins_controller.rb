class AdminsController < ApplicationController
  before_action :authenticate_user!

  def index
    @allphotos = Photo.all
    @configs = Admin.all
    @photo = Photo.new
  end

  def edit
    @config = Admin.find(params[:id])
  end

  def update
    @config = Admin.find(params[:id])
    if @config.update(config_params)
      flash[:success] = "Modificado con Éxito!"
      redirect_to admin_path
    else
      render :edit
    end
  end

  def publicaciones
    @boletines = Padre.where(category: "boletines").order(created_at: :desc)
    @infoutil = Padre.where(category: "infoutil").order(created_at: :desc)
  end

  private
  
  def config_params
    params.require(:admin).permit(:name, :config)
  end
end