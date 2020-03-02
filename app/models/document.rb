require 'csv'

class Document < ApplicationRecord
  belongs_to :user
  validates :photo, presence: true
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
    ocr = {}
    document_infos = {}
    doc_lines = {}
    page1.text.each_line do |li|
      doc_lines[:salaire_brut] = li.strip.split('  ').reject { |block| block == '' }[1].strip.gsub(" ","").to_f if li[/Salaire brut\b/]
      doc_lines[:impot_revenu] = li.strip.split('  ').reject { |block| block == '' }[3].strip.gsub(" ","").to_f if li[/Impôt sur le revenu\b/]
      doc_lines[:salaire_net_paye] = li.strip.split('  ').reject { |block| block == '' }[1].strip.gsub(" ","").to_f if li[/Net payé  [^:]/]
      doc_lines[:conge_n_1] = li.strip.split('  ').reject { |block| block == '' }[1].strip.gsub(" ","").to_f if li[/Solde\b/]
      doc_lines[:conge_n] = li.strip.split('  ').reject { |block| block == '' }[2].strip.gsub(" ","").to_f if li[/Solde\b/]
      doc_lines[:rtt] = li.strip.split('  ').reject { |block| block == '' }[3].strip.gsub(" ","").to_f if li[/Solde\b/]
      document_infos[:siret] = li.strip.split("  ").reject{ |test| test == ""}.select {|item| item.include?("Siret")}.join.split(" ")[2]  if (li[/Siret\b/])
      document_infos[:year] = li.strip.split("  ").reject{ |test| test == ""}.select {|item| item.include?("Période")}.join.split(" ")[3].to_i  if (li[/Période\b/])
      document_infos[:month] = li.strip.split("  ").reject{ |test| test == ""}.select {|item| item.include?("Période")}.join.split(" ")[2]  if (li[/Période\b/])
    end
    document_infos[:month] = traduire_mois(document_infos[:month])
    ocr[:doc_lines] = doc_lines
    ocr[:document_infos] = document_infos
    return ocr
  end

  def fabrique_le_name
    moiss = ['0', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
    return self.name = "#{moiss[month].capitalize} #{year}"
  end

  private

    def traduire_mois(un_mois_en_string)
      moiss = ['0', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
      moiss.each do |mois|
        return moiss.index(mois) if mois == un_mois_en_string.downcase.strip
      end
    end
end
