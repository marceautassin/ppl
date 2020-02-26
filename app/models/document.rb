class Document < ApplicationRecord
  belongs_to :user
  has_many :doc_lines, inverse_of: :document
  has_one_attached :photo

  accepts_nested_attributes_for :doc_lines,
                                reject_if: proc { |attributes| attributes[:name].blank? },
                                allow_destroy: true
end
