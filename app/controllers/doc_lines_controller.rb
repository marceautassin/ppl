class DocLinesController < ApplicationController

  def index
    @documents = Document.all
    @doclines = DocLine.all
    @sum_salaire_net_paye = DocLine.where(category: :salaire_net_paye ).sum(:amount)
  end

end
