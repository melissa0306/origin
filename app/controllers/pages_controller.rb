class PagesController < ApplicationController

before_action :authenticate_user!, except: [:index, :destroy]


  #übersicht
  def index
  end
  #profil
  def profil
  end  
  #karte
  def karte
  end
  #vergleich
  def vergleich
  end
  #infos
  def infos
  end
end
