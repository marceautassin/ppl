class SimulationsController < ApplicationController

  def index

    #REVENU BRUT TOTAL DES 12 DERNIERS MOIS
    @somme = 0
    Document.where(user_id:current_user).last(12).each {|document|
      @somme += document.doc_lines.where(category: :salaire_brut).last.amount
    }



    @revenutotallastyear = @somme.round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1 ').reverse + ' €'


    #SALAIRE JOURNALIER DE REFERENCE
    @sjr_integer = @somme/(261*1.4)
    @sjr = @sjr_integer.round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1 ').reverse + ' €'



    #ALLOCATION JOURNALIERE DE RETOUR A L'EMPLOI
    @arej_m1 =  @sjr_integer * 0.404 + 12
    @arej_m2 = @sjr_integer * 0.57


    if @arej_m1 > @arej_m2
      @are_j_m1 =@arej_m1.round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1 ').reverse + ' €'
    else
      @are_j_m2 = @arej_m2.round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1 ').reverse + ' €'
    end


    # ALLOCATION MENUSELLE DE RETOUR A L'EMPLOI
    @arem_m2 = (@arej_m2 * 30).round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1 ').reverse + ' €'


    # DECOTE EN FONCTION DU PLAFOND
    @arej_m2_postdecote = @arej_m2 * 0.7
    @are_j_m2_postdecote = @arej_m2_postdecote.round(2).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1 ').reverse + ' €'
    @arej_m2_postdecote_plancher = '84.33 €'

    if @arej_m2_postdecote > 84.33
    else
      @arej_m2_postdecote_plancher = '84.33 €'
    end


    # AGE DEPART RETRAITE AU PLUS TOT
    @age_tot = 62

    # AGE DEPART RETRAITE AU PLUS TARD
    @age_plein = 78

   # TRIMESTRES ACQUIS AU "31/12/19"
    @trim_acquis = 43

   # TRIMESTRES RESTANTS AVANT TAUX PLEIN"
    @trim_restants = 129





    #GRAPHIQUES
    @data_amre = []
    document = Document.where(user_id: current_user).pluck(:id).last(2)
    document.each do |doc|
      docline = DocLine.where(document_id: doc, category: 'salaire_brut').first
      @data_amre << [docline.data_entry_period, docline.amount]
    end

    # two_months = ((Date.today - 61)..(Date.today))
    # two_months_before = two_months.map {|d| Date.new(d.year, d.month, 1) }.uniq
    # two_months_before.each do |date|
    #   @data_amre << [date, ]
    # end

    range = (Date.today..(Date.today + (365*2)))
    two_years = range.map {|d| Date.new(d.year, d.month, 1) }.uniq
    two_years.first(7).each do |date|
      @data_amre << [date, @arej_m2 * Time.days_in_month(date.month, date.year)]
    end

    reste = (two_years[7]..(Date.today + (365*2))).map {|d| Date.new(d.year, d.month, 1) }.uniq
    reste.each do |date|
      if @arej_m2_postdecote < 84.33
        @data_amre << [date, @arej_m2 * 0.70 * Time.days_in_month(date.month, date.year)]
      else
        @data_amre << [date, @arej_m2 * Time.days_in_month(date.month, date.year)]
      end
    end

  end
end
