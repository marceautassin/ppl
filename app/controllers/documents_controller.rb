class DocumentsController < ApplicationController
  def index
  end

  def create
    @document = Document.new(year: params_documents["year(1i)"], month: params_documents["month(2i)"] )
    @document.name = "Bulletin_de_salaire_#{params[:document]["year(1i)"]}_#{Date::MONTHNAMES[params[:document]["month(2i)"].to_i]}"
    @document.user = current_user

    if @document.save
      redirect_to documents_path
    else
      render :new
    end
  end

  def new

  end

  def show
  end

  private

  def params_documents
    params.require(:document).permit(:photo, ["year(1i)"], ["month(2i)"] )
  end
end
