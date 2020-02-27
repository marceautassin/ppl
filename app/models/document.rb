class Document < ApplicationRecord
  belongs_to :user
  has_many :doc_lines, inverse_of: :document
  has_one_attached :photo

  accepts_nested_attributes_for :doc_lines,
                                allow_destroy: true

  include PgSearch::Model
    pg_search_scope :global_search,
      against: [ :name, :year, :month, :entreprise, :siret, :address ],
      using: {
        tsearch: { prefix: true }
      }
end
