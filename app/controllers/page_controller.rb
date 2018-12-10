require "net/http"

class PageController < ApplicationController
  def index
  end

  def nosotros
  end

  def simbolos
  end

  def galeria
    galerysource = "fbapi"
    fbpageid = 2210627005623617
    access_token = "EAAEoct4isjABAOXwaRlnOcbpOkZAozZC4BllKDrmkqCKBGUYfnj46cL5BiC7ZA5ywAWrsv8q3UV0m54ZAZAlpm5BLLOlmGhZCZCrC5swIf7ffzZBSdexvarlJ7BZChqUb742ycvAy4hfLJNEnkSsIc962Jf5kIFKZARBkMmJRZCrzNolwZDZD"
    if galerysource == "fbapi"
      @photos = []
      @errormsg = ""
      begin
        url = "https://graph.facebook.com/v3.2/#{fbpageid}/photos?access_token=#{access_token}"
        resp = Net::HTTP.get_response(URI.parse(url))
        response = JSON.parse(resp.body)
        facebookapi = response.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
        facebookapi[:data].each {|p| @photos << p.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}}
      rescue StandardError => @photos
        @photos = [{:id => "Error"}]
        @errormsg = response
      end
    else
      @photos
    end
  end

  def contacto
  end


end
