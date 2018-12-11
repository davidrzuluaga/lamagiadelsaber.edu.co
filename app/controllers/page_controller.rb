require "net/http"

class PageController < ApplicationController
  def index
  end

  def nosotros
  end

  def simbolos
  end

  def galeria
    galerysource = Configura.where(name:"galerysource").first.config
    @photos = []
    if galerysource == "fbapi" || galerysource == "mix"
      fbpageid = Configura.where(name:"fbpageid").first.config
      access_token = Configura.where(name:"fbaccess_token").first.config
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
    if galerysource == "database" || galerysource == "mix"
      urlphoto = []
      Photo.where(source: "url").each {|ph| @photos << {id: ph.id, url: ph.url, title: ph.title}}
      Photo.where(source: "fb").each {|ph| @photos << {id: ph.id, url: "https://graph.facebook.com/#{ph.url}/picture?width=160&height=160", title: ph.title}}
    end
  end

  def contacto
  end


end
