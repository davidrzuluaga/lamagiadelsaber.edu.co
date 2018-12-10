class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def publicaciones
    @boletines = Padre.where(category: "boletines").order(:created_at)
    @infoutil = Padre.where(category: "infoutil").order(:created_at)
  end

end
