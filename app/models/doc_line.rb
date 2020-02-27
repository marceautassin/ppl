class DocLine < ApplicationRecord
  include Enumerable

  belongs_to :document, inverse_of: :doc_lines

  enum category: [ :salaire_brut, :salaire_net_paye, :impot_revenu, :conge_n_1, :conge_n, :rtt]

end
