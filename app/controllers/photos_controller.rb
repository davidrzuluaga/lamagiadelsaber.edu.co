require "net/http"

class PhotosController < ApplicationController
  before_action :authenticate_user!

  def galeria
    galerysource = Admin.where(name:"galerysource").first.config
    @photos = []
    if galerysource == "fbapi" || galerysource == "mix"
      fbpageid = Admin.where(name:"fbpageid").first.config
      access_token = Admin.where(name:"fbaccess_token").first.config
      @errormsg = ""
      begin
        url = "https://graph.facebook.com/v3.2/#{fbpageid}/photos?access_token=#{access_token}"
        resp = Net::HTTP.get_response(URI.parse(url))
        response = JSON.parse(resp.body)
        response["data"].each {|ph| @photos << {id:"#{ph['id']}", url: "https://graph.facebook.com/#{ph['id']}/picture?width=160&height=160", title: ""}}
      rescue StandardError => @photos
        @photos = [{id: "1018888671464129", url: "https://graph.facebook.com/1018888671464129/picture?width=160&height=160", title: ""}]
        @errormsg = response
      end
    end
    if galerysource == "interno" || galerysource == "mix"
      urlphoto = []
      Photo.where(source: "url").each {|ph| @photos << {id: ph.id, url: ph.url, title: ph.title}}
      Photo.where(source: "fb").each {|ph| @photos << {id: ph.id, url: "https://graph.facebook.com/#{ph.url}/picture?width=160&height=160", title: ph.title}}
    elsif galerysource != "fbapi"
      @photos = [{id: "1018888671464129", url: "https://graph.facebook.com/1018888671464129/picture?width=160&height=160", title: ""}]      
      @errormsg = "Configuracion de fotos pendiente o incorrecta: galerysource puede ser (interno, fbapi o mix) en <a href='/admin'>admin</a>".html_safe
    end
  end

    def create
      @photo = Photo.new(photo_params)
      if @photo.save
        flash[:success] = "Creada con Éxito!"
        redirect_to admin_path
      else
       render :new 
      end
    end
  
    def destroy
      photo = Photo.find(params[:id])
      photo.destroy
      flash[:success] = "Eliminada con Éxito!"
      redirect_to admin_path
    end
  
    private
    
    def photo_params
      params.require(:photo).permit(:title, :source, :url)
    end
end
