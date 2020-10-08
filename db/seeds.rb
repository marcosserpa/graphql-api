# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

arthur = Author.create(name: 'Arthur Conan Doyle', email: 'contact@arthurconandoyle.com')
tolkien = Author.create(name: 'J. R. R. Tolkien', email: 'contact@tolkienbooks.com')

lost_world_descripion = "The Lost World is a science fiction novel by British writer Arthur Conan Doyle, published in 1912, concerning an expedition to a plateau in the Amazon basin of South America where prehistoric animals still survive"

silmarillion_description = "The Silmarillion, along with many of J. R. R. Tolkien's other works, forms an extensive though incomplete narrative of Eä, a fictional universe that includes the Blessed Realm of Valinor, the once-great region of Beleriand, the sunken island of Númenor, and the continent of Middle-earth, where Tolkien's most popular works—The Hobbit and The Lord of the Rings—take place."

Book.create(title: 'The Lost World', description: lost_world_descripion, author: arthur)
Book.create(title: 'The Silmarillion', description: silmarillion_description, author: tolkien)
