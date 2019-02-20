require 'rails_helper'

RSpec.describe User, type: :model do
  
  before :each do 
    User.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!(:users) 
    
    User.new(first_name: "first", last_name: "last", email: "duplicate@mail.com", password_digest: "123").save
  end

  context "validation tests" do 
    it "ensure presence of first name" do 
      user = User.new(last_name: "last", email: "name@mail.com", password_digest: "123").save
      expect(user).to eq(false)
    end

    it "ensure presence of first name" do 
      user = User.new(first_name: "first", email: "name@mail.com", password_digest: "123").save
      expect(user).to eq(false)
    end

    it "ensure email presence" do 
      user = User.new(first_name: "first", last_name: "last", password_digest: "123").save
      expect(user).to eq(false)
    end

    it "ensure no duplicate of emails" do
      user = User.new(first_name: "first", last_name: "last", email: "duplicate@mail.com", password_digest: "123").save
      expect(user).to eq(false)
    end

    it "ensure presence of password" do
      user = User.new(first_name: "first", last_name: "last", email: "mail@mail.com").save
      expect(user).to eq(false)      
    end

    it "should have save successfully" do 
      user = User.new(first_name: "first", last_name: "last", email: "name@mail.com", password_digest: "123").save
      expect(user).to eq(true)
    end 
  end
end
