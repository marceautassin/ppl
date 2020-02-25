@documents = Document.all
@documents.destroy
puts 'Création de 10 fiches de paies...'
  user = User.new(
    email: 'bertrandbussac@lewagon.com',
    password: 'azerty'
  )
  # period = (Date.new(2019, 8.Date.new(2020, 2)).select {|d| d.day == 1}
  # period.each_with_index do |month, i|{
  #   document = Document.new(
  #     user_id:    1,
  #     month: Date::MONTHNAMES[period[i].month],
  #     year:  period[i].year
  #   )
  #   document.save!
  # }
    document = Document.new(
      name: "fiche de paie",
      user_id:    User.first.id,
      month: 9,
      year:  2018
    )
    document.save!
    doclines = DocLine.new(
        documents_id: Document.first.id,
        category: 0,
        amount: 250
      )
puts 'Finished!'
