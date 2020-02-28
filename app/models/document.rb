require 'csv'

class Document < ApplicationRecord
  belongs_to :user
  has_many :doc_lines, inverse_of: :document, dependent: :destroy
  has_one_attached :photo

  accepts_nested_attributes_for :doc_lines,
                                allow_destroy: true

  include PgSearch::Model
    pg_search_scope :global_search,
      against: [ :name, :year, :month, :entreprise, :siret, :address ],
      using: {
        tsearch: { prefix: true }
      }

  def construction_hash(chemin_to_pdf)
    pdf_reader = PDF::Reader.new(chemin_to_pdf)
    page1 = pdf_reader.pages.first
    lecture_pdf = {}
    page1.text.each_line do |li|
      lecture_pdf[:salaire_brut] = li.strip.split('  ').reject { |block| block == '' }[1].strip.gsub(" ","").to_f if li[/Salaire brut\b/]
      lecture_pdf[:impot_revenu] = li.strip.split('  ').reject { |block| block == '' }[3].strip.gsub(" ","").to_f if li[/Impôt sur le revenu\b/]
      lecture_pdf[:salaire_net_paye] = li.strip.split('  ').reject { |block| block == '' }[1].strip.gsub(" ","").to_f if li[/Net payé  [^:]/]
      lecture_pdf[:conge_n_1] = li.strip.split('  ').reject { |block| block == '' }[1].strip.gsub(" ","").to_f if li[/Solde\b/]
      lecture_pdf[:conge_n] = li.strip.split('  ').reject { |block| block == '' }[2].strip.gsub(" ","").to_f if li[/Solde\b/]
      lecture_pdf[:rtt] = li.strip.split('  ').reject { |block| block == '' }[3].strip.gsub(" ","").to_f if li[/Solde\b/]
    end
    return lecture_pdf
    raise
  end
end
