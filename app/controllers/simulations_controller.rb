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

     # DUREE D'INDEMNISATION





  end
end
