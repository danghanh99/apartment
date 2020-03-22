User.create!(name: "mod Hanh",
             email: "ldhanh1999@gmail.com",
             password: "ledanghanh",
             password_confirmation: "ledanghanh",
             phone_number: 2363842308,
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

users = User.order(:created_at).take(6)
5.times do
  users.each { |user|
    user.homes.create!(name: "Nha a",
                       status: "available",
                       address: "197 nguyen luong bang, lien chieu, da nang",
                       number_floors: 3,
                       full_price: 60000000)
  }
end
