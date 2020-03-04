class SimulationsController < ApplicationController

  def index

    #REVENU BRUT TOTAL DES 12 DERNIERS MOIS
    @somme = 0
    Document.last(12).each {|document|
      @somme += document.doc_lines.where(category: :salaire_brut).last.amount
    }
    @revenutotallastyear = @somme.round(2).to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'


    #SALAIRE JOURNALIER DE REFERENCE
    @sjr_integer = @somme/(261*1.4)
    @sjr = @sjr_integer.round(2).to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'


    #ALLOCATION JOURNALIERE DE RETOUR A L'EMPLOI
    @arej_m1 =  @sjr_integer * 0.404 + 12
    @arej_m2 = @sjr_integer * 0.57

    if @arej_m1 > @arej_m2
      @are_j_m1 =@arej_m1.round(2).to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'
    else
      @are_j_m2 = @arej_m2.round(2).to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'
    end


    # ALLOCATION MENUSELLE DE RETOUR A L'EMPLOI
    @arem_m2 = (@arej_m2 * 30).round(2).to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'


    # DECOTE EN FONCTION DU PLAFOND
    @arej_m2_postdecote = @arej_m2 * 0.7
    @are_j_m2_postdecote = @arej_m2_postdecote.round(2).to_s.reverse.gsub(/...(?=.)/,'\& ').reverse + ' €'
    @arej_m2_postdecote_plancher = '84.33 €'

    if @arej_m2_postdecote > 84.33

    else
      @arej_m2_postdecote_plancher = '84.33 €'
    end

    #GRAPHIQUES
    range = ((Date.today - 365*2)..Date.today)
    two_years = range.map {|d| Date.new(d.year, d.month, 1) }.uniq

    @data_amre = []

    seven_months = (two_years.first(7).last - two_years.first(7).first).to_i
    two_years.first(7).each do |month|
      @data_amre << [month, @arej_m2 * seven_months]
    end

    reste = (((two_years[7]..Date.today).last) - (two_years[7]..Date.today).first).to_i
    (two_years[7]..Date.today).each do |month|
      if @arej_m2 * 0.30 > 84.33
        @data_amre << [month, @arej_m2 * 0.30 * reste]
      else
        @data_amre << [month, @arej_m2 * reste]
      end
    end

     # DUREE D'INDEMNISATION





  end
end
