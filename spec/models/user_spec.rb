require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "validation tests" do 
    ########################################### HAPPY ###########################################
    it "ensure presence of first name" do 
      user = User.new(last_name: "last", email: "name@mail.com", password: "123").save
      expect(user).to eq(false)
    end

    
    it "ensure presence of last name" do 
      user = User.new(first_name: "first", email: "name@mail.com", password: "123").save
      expect(user).to eq(false)
    end
    
    it "ensure email presence" do 
      user = User.new(first_name: "first", last_name: "last", password: "123").save
      expect(user).to eq(false)
    end
    
    it "ensure no duplicate of emails" do
      user = User.new(first_name: "first", last_name: "last", email: "duplicate@mail.com", password: "123").save
      expect(user).to eq(false)
    end
    
    it "should have save successfully" do 
      user = User.new(first_name: "first", last_name: "last", email: "name@mail.com", password: "123").save
      expect(user).to eq(true)
    end

    it "ensure presence of password" do
      user = User.new(first_name: "first", last_name: "last", email: "mail@mail.com").save
      expect(user).to eq(false)      
    end
    ########################################### EDGY ###########################################
    it "ensure presence of first name - EDGY" do 
      user = User.new(first_name: "first", last_name: "last", email: "name@mail.com", password: "123").save
      expect(user).to eq(true)
    end


    it "ensure presence of last name - EDGY" do 
      user = User.new(first_name: "first", last_name: "last", email: "name@mail.com", password: "123").save
      expect(user).to eq(true)
    end
    
    it "should have save successfully - EDGY" do 
      user = User.new(first_name: "first", last_name: "last", email: "name@mail.com", password: "123").save
      expect(user).to_not eq(false)
    end

    before :each do 
      User.delete_all
      ActiveRecord::Base.connection.reset_pk_sequence!(:users) 
      
      User.new(first_name: "first", last_name: "last", email: "duplicate@mail.com", password: "123").save
    end
  end

  context "scope tests" do 
    let (:admin_params_1) { {first_name: 'first', last_name: 'last', email: 'mail1.com', password: "123", role: "admin"} }
    let (:admin_params_2) { {first_name: 'first', last_name: 'last', email: 'mail2.com', password: "123", role: "admin"} }
    let (:member_params_1) { {first_name: 'first', last_name: 'last', email: 'mail3.com', password: "123", role: "member"} }
    let (:member_params_2) { {first_name: 'first', last_name: 'last', email: 'mail4.com', password: "123", role: "member"} }
    let (:member_params_3) { {first_name: 'first', last_name: 'last', email: 'mail5.com', password: "123", role: "member"} }

    before(:each) do 
      ActiveRecord::Base.connection.reset_pk_sequence!(:users)
      User.new(admin_params_1).save
      User.new(admin_params_2).save
      User.new(member_params_1).save
      User.new(member_params_2).save
      User.new(member_params_3).save
    end 
    ########################################### HAPPY ########################################### 
    
    it 'should return 2 admin users' do 
      expect(User.admin_users.size).to eq(2)
    end

    it 'should return 3 member users' do 
      expect(User.member_users.size).to eq(3)
    end
  end

  context "association tests" do 
    ########################################### HAPPY ########################################### 
    it "user has_many attendees" do 
      expect(User.reflect_on_association(:attendees).macro).to eq(:has_many)
    end
    
    it "user has_many events" do 
      expect(User.reflect_on_association(:events).macro).to eq(:has_many)
    end
    
    it "user has_many_through attendees" do 
      expect(User.reflect_on_association(:events).options).to eq({:through => :attendees})
    end

    ########################################### EDGY ###########################################

    it "user do not has_many attendees" do 
      expect(User.reflect_on_association(:attendees).macro).to_not eq(:belongs_to)
    end

    it "user do not has_many events" do 
      expect(User.reflect_on_association(:events).macro).to_not eq(:many_to_many)
    end

    it "user do not has_many_through attendees" do 
      expect(User.reflect_on_association(:events).options).to_not eq({:through => :users})
    end
  end
end
