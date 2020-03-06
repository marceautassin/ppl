puts 'Création des fiches de paies...'
  user = User.new(
    first_name: 'Maxime',
    last_name: 'L',
    social_security_number: '188091212365476',
    email: 'maxime.l@administrophobe.fr',
    password: 'azerty'
  )
  user.photo.attach(io: File.open("app/assets/images/villeret.jpg"), filename: 'villeret.jpg', content_type: 'image/jpg')
  user.save!

  period = (Date.new(2010, 1)..Date.new(2016, 12)).select {|d| d.day == 1}

  period.each do |date|
    moiss = ['0', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
    docname = "#{moiss[date.month].capitalize} #{date.year}"

    document = Document.new(
      name: "#{docname}",
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
      amount: rand(3768.84..3968.84),
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

  puts 'Création des fiches de paies 2010 / 2016 ok '

  period = (Date.new(2017, 1)..Date.new(2017, 12)).select {|d| d.day == 1}

  period.each do |date|
    moiss = ['0', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
    docname = "#{moiss[date.month].capitalize} #{date.year}"

    document = Document.new(
      name: "#{docname}",
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
      amount: rand(4026.84..4132.84),
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

  puts 'Création des fiches de paies 2015 / 2017 ok '

  period = (Date.new(2018, 1)..Date.new(2018, 12)).select {|d| d.day == 1}

  period.each do |date|
    moiss = ['0', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
    docname = "#{moiss[date.month].capitalize} #{date.year}"

    document = Document.new(
      name: "#{docname}",
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
      amount: rand(4526.84..4832.84),
      data_entry_period: Date.new(document.year, document.month, 1)
    )
    salaire_brut.save!


    impot_revenu = DocLine.new(
      document_id: document.id,
      category: :impot_revenu,
      amount: (salaire_brut.amount / 9.54).round(2),
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

  puts 'Création des fiches de paies 2018 ok '

  period = (Date.new(2019, 1)..Date.new(2019, 6)).select {|d| d.day == 1}

  period.each do |date|
    moiss = ['0', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
    docname = "#{moiss[date.month].capitalize} #{date.year}"

    document = Document.new(
      name: "#{docname}",
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
      amount: rand(5026.84..5832.84),
      data_entry_period: Date.new(document.year, document.month, 1)
    )
    salaire_brut.save!


    impot_revenu = DocLine.new(
      document_id: document.id,
      category: :impot_revenu,
      amount: (salaire_brut.amount / 9.54).round(2),
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

  puts 'Création des fiches de paies 2019 ok '

 period = (Date.new(2019, 10)..Date.new(2020, 2)).select {|d| d.day == 1}

  period.each do |date|
    moiss = ['0', 'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre']
    docname = "#{moiss[date.month].capitalize} #{date.year}"

    document = Document.new(
      name: "#{docname}",
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
      amount: rand(3768.84..3968.84),
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

  puts 'Création des fiches de paies fin 2019 début 2020 ok '

puts 'Finished!'
