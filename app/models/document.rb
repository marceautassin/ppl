class Document < ApplicationRecord
  belongs_to :user
  has_many :doc_lines
end
