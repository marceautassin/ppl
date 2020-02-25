class DocumentsController < ApplicationController

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(document_params)
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
end
