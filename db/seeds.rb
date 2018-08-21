Trailer.create(name: 'Batman & Robin')
Trailer.create(name: 'Star Wars: Episode I – The Phantom Menace')
Trailer.create(name: 'Heart of a Dog')
user = User.create(email: 'steven.spielberg@gmail.com',
                   password: 'qwerty', password_confirmation: 'qwerty')

puts 'Trailers created!'
puts "User credentials -H 'X-User-Email: #{user.email}'" \
     " -H 'X-User-Token: #{user.authentication_token}'"
