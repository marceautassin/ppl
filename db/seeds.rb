puts 'Création des fiches de paies...'
  user = User.new(
    email: 'bertrandbussac@gmail.com',
    password: 'azerty'
  )
  user.save!

  period = (Date.new(2018, 8)..Date.new(2020, 2)).select {|d| d.day == 1}

  period.each do |date|

    document = Document.new(
      name: "#{Date::MONTHNAMES[date.month]} #{date.year}",
      entreprise: 'Le Wagon',
      siret: '79494991700023',
      address: '107, cours Balguerie Stuttenberg 33000 Bordeaux',
      user_id:    user.id,
      month: date.month,
      year:  date.year
    )
    document.photo.attach(io: File.open("app/assets/images/fiche-de-paie.pdf"), filename: 'fiche-de-paie.pdf', content_type: 'application/pdf')

    document.save!

    salaire_brut = DocLine.new(
      document_id: document.id,
      category: :salaire_brut,
      amount: rand(3768.84..4268.84),
      data_entry_period: Date.new(document.year, document.month, 1)
    )
    salaire_brut.save!


    impot_revenu = DocLine.new(
      document_id: document.id,
      category: :impot_revenu,
      amount: (salaire_brut.amount / 6.54).round(2),
      data_entry_period: Date.new(document.year, document.month, 1)
    )
    impot_revenu.save!

    salaire_net_paye = DocLine.new(
      document_id: document.id,
      category: :salaire_net_paye,
      amount: salaire_brut.amount - impot_revenu.amount,
      data_entry_period: Date.new(document.year, document.month, 1)
    )
    salaire_net_paye.save!

    conge_n_1 = DocLine.new(
      document_id: document.id,
      category: :conge_n_1,
      amount: rand(20..29),
      data_entry_period: Date.new(document.year, document.month, 1)
    )
    conge_n_1.save!

    conge_n = DocLine.new(
      document_id: document.id,
      category: :conge_n,
      amount: rand(20..29),
      data_entry_period: Date.new(document.year, document.month, 1)
    )
    conge_n.save!

    rtt = DocLine.new(
      document_id: document.id,
      category: :rtt,
      amount: rand(0..4),
      data_entry_period: Date.new(document.year, document.month, 1)
    )
    rtt.save!

  end

puts 'Finished!'
