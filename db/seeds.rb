# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
	#Utentis.create(email: 'admin@labor.local', encrypted_password: '')
	utenteadmin = Utenti.create(nome: 'admin', email: 'admin@labor.local', encrypted_password: 'pasword')
