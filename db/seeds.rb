# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create users
require "faker"
require "date"
Booking.destroy_all
User.destroy_all
Campervan.destroy_all

puts "Creating 4 users..."

user = User.new(email: "briz@superdry.com", first_name: "Briz", last_name: "LM")
user.password = "sunshine"
user.save

user = User.new(email: "alizeh@trails.com", first_name: "Alizeh", last_name: "K")
user.password = "sunshine"
user.save



user = User.new(email: "leeanna@hollywood.com", first_name: "Leeanna", last_name: "S")
user.password = "sunshine"
user.save


puts "Selecting 2 random campervan owners..."

campervan_owners = [User.all.sample, User.all.sample]

brands = %w(Volkswagen Nissan Mercedes Ford Honda Toyota)
models = %w(X1 T3 W7 LT DRIVE SUPER quicks)
address = ["Plaine de Baud
35000 Rennes","Thabor, Saint Hélier
Rennes","Sud-Gare
Rennes","13-1 Rue des Fossés
35000 Rennes", "Hohenzollerndamm 5, Berlin", "Karl-Marx-Str. 30, Berlin", "Planufer 80, Berlin", "Torstr. 70, Berlin", "Checkpoint Charlie, Berlin", "Alexanderplatz, Berlin"]

puts "Creating 13 campervans and assigning them to the 2 owners..."

c = 1
14.times do
  p "using picture #{c}"
  filepath = "./db/seed-images/camper#{c}.jpeg"
  file = File.open(filepath)
  puts "creating campervan #{c}"
  filename = "camper#{c}.jpeg"
  features = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
  campervan = Campervan.new(title: Faker::FunnyName.two_word_name, description: Faker::GreekPhilosophers.quote, features: features, brand: brands.sample, model: models.sample, capacity: (1..6).to_a.sample, price_per_night: (40..100).to_a.sample, address: address.sample)
  campervan.user = campervan_owners.sample
  campervan.photo.attach(io: file, filename: filename, content_type: 'image/jpeg')
  campervan.save
  c += 1
end

puts "Creating 10 bookings randomly for all users"

# create bookings
10.times do
start_date = Date.new(2020, 11, 15)
days = (rand*10).floor
end_date = start_date + days

campervan = Campervan.all.sample
user = User.all.sample
unless campervan.user != user
campervan = Campervan.all.sample
user = User.all.sample
end

booking = Booking.new(start_date: start_date, end_date: end_date, total_price: campervan.price_per_night * days)
booking.campervan = campervan
booking.user = user
booking.save
end

#creating user without bookings

user = User.new(email: "thomas@dogs.com", first_name: "Thomas", last_name: "P")
user.password = "sunshine"
user.save

p "DOOOOOONE!!!!!!!! GET BACK TO WORK!!!!!!"
