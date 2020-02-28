require 'open-uri'
class DocumentsController < ApplicationController

  def index
    if params[:query].present?
      @documents = Document.global_search(params[:query])
    else
      @documents = Document.all
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(year: params_documents["year(1i)"], month: params_documents["month(2i)"], photo: params_documents[:photo] )
    @document.name = "#{Date::MONTHNAMES[params[:document]["month(2i)"].to_i]} #{params[:document]["year(1i)"]}"
    @document.user = current_user

    if @document.save
      redirect_to edit_document_path(@document)
    else
      render :new
    end
  end

  def edit
    @document = Document.find(params[:id])
    #path =  request.base_url + Rails.application.routes.url_helpers.rails_blob_path(@document.photo, only_path: true)
    #le probleme est que j'ai pas la bonne url , et je vois clairement pas !!!!!!!!!!
    #path = ActionController::Base.helpers.cl_image_url(@document.photo)
    #
    result = Cloudinary::Search.max_results(1).execute
    pdf = URI.open(result["resources"][0]["url"])
    ocr = @document.construction_hash(pdf)
    # ocr = {:salaire_brut=>"5083.33",
    #   :salaire_net_paye=>"3868.84",
    #   :impot_revenu=>"590.75",
    #   :conge_n_1=>"24.0",
    #   :conge_n=>"2.08",
    #   :rtt=>"2.88"}
    ocr.each do |key, value|
      dl = DocLine.new(category: key, amount: value.to_f)
      dl.data_entry_period = Date.new(@document.year, @document.month, 1)
      dl.document = @document
      dl.save!
      flash[:notice] = 'Votre bulletin a été sauvegardé.'
    end
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(params_documents)
      redirect_to @document, notice: 'Successfully updated document'
    else
      render :edit
    end

  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path
  end


  private

  def params_documents
    params.require(:document).permit(:photo, ["year(1i)"], ["month(2i)"], doc_lines_attributes: [:id, :name, :category, :amount] )
  end
end
