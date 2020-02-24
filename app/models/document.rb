class Document < ApplicationRecord
  belongs_to :user
  has_many :doc_lines
  has_one_attached :photo
end
