class DocLinesController < ApplicationController

  def index
    @documents = Document.where(user: current_user)
    @documents_id = @documents.pluck(:id)
    @my_doclines = DocLine.select {|line| @documents_id.include? (line.document_id)}
    define_params
    @rtt = filter_by('rtt').last.to_i
    @revenu_an = filter_by('salaire_net_paye').sum.round.to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'
  end

  def new
    @doc_line = DocLine.new
  end

  def create
  end

  private

  def define_params
    if params[:query] && params[:query][:data_entry_period] != ""
      @start_at = Date.parse(params[:query][:data_entry_period].split(' to ').first)
      @end_at = Date.parse(params[:query][:data_entry_period].split(' to ').last)
    else
      @start_at = @my_doclines.first.data_entry_period
      @end_at = @my_doclines.last.data_entry_period
    end
  end

  def filter_by(category)
    @my_doclines.select{|line| line.category == category && line.data_entry_period >= @start_at && line.data_entry_period <= @end_at }.pluck(:amount)
  end
end
