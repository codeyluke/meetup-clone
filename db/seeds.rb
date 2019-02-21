user = {}
user['password'] = '123'
user['password_confirmation'] = '123'

User.new(first_name: 'luke', last_name: 'lee', email: 'luke@gmail.com', password: '234', password_confirmation: '234', role: "admin").save ;

ActiveRecord::Base.transaction do
    10.times do 
        user['first_name'] = Faker::Name.first_name 
        user['last_name'] = Faker::Name.last_name
        user['email'] = Faker::Internet.email

        User.create(user)
    end
end