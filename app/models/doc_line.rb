class DocLine < ApplicationRecord
  belongs_to :documents

  enum type: [:salaire_brut, :salaire_net, :n_ss]

end
