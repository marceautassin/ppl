class DocLinesController < ApplicationController

  def index
    @doc_line = DocLine.new
    @documents = Document.where(user: current_user)
    @documents_id = @documents.map{|doc| doc.id}
    @my_doclines = DocLine.select {|line| @documents_id.include? (line.document_id)}
    @rtt = filter_by('rtt').last.to_i
    @start_at = params[:methodParam[0]]
    @end_at = params[:methodParam[1]]
    @revenu_an = filter_by('salaire_net_paye').last(12).sum.round.to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'


  end

  def index_ajax_3

    @doc_line = DocLine.new
    @documents = Document.where(user: current_user)
    @documents_id = @documents.map{|doc| doc.id}
    @my_doclines = DocLine.select {|line| @documents_id.include? (line.document_id)}
    @rtt = filter_by('rtt').last.to_i
    @start_at = params[:methodParam[0]]
    @end_at = params[:methodParam[1]]
    @revenu_an = filter_by('salaire_net_paye').last(12).sum.round.to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'
    respond_to do |format|
        format.html { redirect_to doc_lines_path(start_at: params["start_at"], end_at:params["end_at"]) }
        format.js
    end

  end

  def new
    @doc_line = DocLine.new
  end

  def create
  end

  private

  def filter_by(category)
    @my_doclines.select{|line| line.category == category}.map{|line| line.amount}
  end
end
