class DocumentsController < ApplicationController

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(document_params)
  end

  def create
    @document = Document.new(year: params_documents["year(1i)"], month: params_documents["month(2i)"], photo: params_documents[:photo] )
    @document.name = "Bulletin_de_salaire_#{params[:document]["year(1i)"]}_#{Date::MONTHNAMES[params[:document]["month(2i)"].to_i]}"
    @document.user = current_user

    if @document.save
      redirect_to documents_path
    else
      render :new
    end
  end

  def new
    @document = Document.new
  end

  def destroy
    @document = Document.find(document_params)
  end

  private

  def document_params
    params.require(:document).permit(:name, :user_id, :year, :month)
  end

  private

  def params_documents
    params.require(:document).permit(:photo, ["year(1i)"], ["month(2i)"] )
  end
end
