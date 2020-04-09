User.create!(name: "mod Hanh",
             email: "Admin@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             phone_number: 2363842308,
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

users = User.order(:created_at).take(6)
x = 1
5.times do
  users.each { |user|
    home = user.homes.create!(name: "Nha #{x}",
                              status: "available",
                              address: "197 nguyen luong bang, lien chieu, da nang",
                              number_floors: 3,
                              full_price: x * 10000000)
    number_room_default = 100
    2.times do
      home.rooms.create!(
        user_id: user.id,
        length: 25,
        width: 7,
        height: 5,
        area: 175,
        number_room: number_room_default,
        price: 2000000,
        price_unit: "VND",
        status: "available",
      )
      number_room_default += 1
    end

    x += 1
  }
end

User.create!(name: "user test",
             email: "UserTest@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             phone_number: 2363842308,
             admin: false,
             activated: true,
             activated_at: Time.zone.now)
