# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.collection.drop
Case.collection.drop
User.collection.drop

Admin.create! email: 'admin@cszero.com', password: 'secret'
User.create! email: 'user@cszero.com', password: 'secret'

Case.create! type: 'email', uf: 'RJ', reason: 'suggestion', notes: 'Writes too much.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T10:34:45Z')
Case.create! type: 'chat', uf: 'RJ', reason: 'compliment', notes: 'Writes too little.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T11:34:45Z')
Case.create! type: 'chat', uf: 'MG', reason: 'suggestion', notes: 'A bit of cheese.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T12:34:45Z')
Case.create! type: 'chat', uf: 'MG', reason: 'suggestion', notes: 'A lot of cofee.', email: 'user@cszero', date: DateTime.strptime('2017-08-15T13:34:45Z')
Case.create! type: 'phone', uf: 'RS', reason: 'question', notes: 'Bombastic.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T09:34:45Z')
Case.create! type: 'email', uf: 'AC', reason: 'compliment', notes: 'Mythical.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T10:34:45Z')
Case.create! type: 'phone', uf: 'DF', reason: 'suggestion', notes: 'Ugly voice.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T11:34:45Z')
Case.create! type: 'phone', uf: 'RJ', reason: 'question', notes: 'Nice voice.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T12:34:45Z')
Case.create! type: 'email', uf: 'RJ', reason: 'compliment', notes: 'Write well.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T13:34:45Z')
Case.create! type: 'phone', uf: 'RJ', reason: 'suggestion', notes: 'Ugly voice.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T14:34:45Z')
Case.create! type: 'chat', uf: 'DF', reason: 'compliment', notes: 'Slow typer.', email: 'user@cszero', date: DateTime.strptime('2017-08-16T15:34:45Z')
