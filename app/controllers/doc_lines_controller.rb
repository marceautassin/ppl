class DocLinesController < ApplicationController

  def index
    @documents = Document.where(user: current_user)
    @documents_id = @documents.map{|doc| doc.id}
    @my_doclines = DocLine.select {|line| @documents_id.include? (line.document_id)}
    @rtt = filter_by('rtt').last.to_i
    @revenu_an = filter_by('salaire_net_paye').last(12).sum.round.to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'
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
