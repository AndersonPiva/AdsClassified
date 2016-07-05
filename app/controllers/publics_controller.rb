class PublicsController < ApplicationController

  def index
    @total_anuncios = Advertisement.all.size
    @cities = City.all.order(name: :asc)
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
