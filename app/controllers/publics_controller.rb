class PublicsController < ApplicationController

  def index
    @total_anuncios = Advertisement.all.size
    @cities_concordia = City.where(microregion: 'concordia').order(name: :asc)
    @cities_chapeco = City.where(microregion: 'chapeco').order(name: :asc)
    @cities_xanxere = City.where(microregion: 'xanxere').order(name: :asc)
  end

  def privacy
    respond_to do |format|
      format.html
      format.pdf {
        render pdf: "politica_de_privacidade.pdf",
               footer: { center: "[page] de [topage]" }
      }
    end
  end

end
