class DocLine < ApplicationRecord
  include Enumerable

  belongs_to :document

  enum category: [ :salaire_brut, :salaire_net_paye, :impot_revenu, :conge_n_1, :conge_n, :rtt]

end
