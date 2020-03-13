User.create!(name: "mod Hanh",
             email: "ldhanh1999@gmail.com",
             password: "ledanghanh",
             password_confirmation: "ledanghanh",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

users = User.order(:created_at).take(6)
5.times do
  users.each { |user|
    user.homes.create!(name: "Nha a",
                       status: "available",
                       number_floors: 3,
                       price: 60000000)
  }
end
