require 'rails_helper'

RSpec.feature "Users", type: :feature do
  ########################################### HAPPY ###########################################
  before :each do 
    ActiveRecord::Base.connection.reset_pk_sequence!(:users) 
    user = User.new(first_name: "jacky", last_name: "john", email: "win@email.com", password: "123").save
  end
  
  context "Create New User" do 
    scenario 'User Created Successfully' do 
      visit new_user_path
      within('form') do 
        fill_in 'user[first_name]', with: 'john'
        fill_in 'user[last_name]', with: 'last'
        fill_in 'user[email]', with: 'email@email.com'
        fill_in 'user[password]', with: '123'
        fill_in 'user[password_confirmation]', with: '123'
      end
      
      click_button 'Create User' 
      expect(page).to have_content('User was successfully created.')
    end
  end

  ####### ISSUE ON HOW TO INCORPORATE HELPER METHOD INTO CAPYBARA #######
  # context "Update User" do 
  #   scenario "Edited Successfully" do 
  #     user = User.first
  #     visit edit_user_path(user.id)
  #     within('form') do 
  #       fill_in 'user[first_name]', with: 'changed'
  #       fill_in 'user[last_name]', with: 'last changed'
  #       fill_in 'user[email]', with: 'changed@email.com'
  #     end
      
  #     click_button "Update User"
  #     expect(page).to have_content('User was successfully updated.')
  #   end
  # end

  context "Destroy User" do 
    scenario "Destroyed Successfully" do 
      User.last.destroy
      users = User.all
      expect(users.length).to eq(0)
    end
  end

  ########################################### EDGY ###########################################
  context "Create New User" do 
    scenario 'User failed to be created' do 
      visit new_user_path
      within('form') do 
        fill_in 'user[last_name]', with: 'last'
        fill_in 'user[email]', with: 'email@email.com'
        fill_in 'user[password]', with: '123'
        fill_in 'user[password_confirmation]', with: '123'
      end

      click_button 'Create User' 
      expect(page).to have_content("First name can't be blank")
    end
  end
  
  ####### ISSUE ON HOW TO INCORPORATE HELPER METHOD INTO CAPYBARA #######
  # context "Update User" do 
  #   scenario "Edited Failed" do 
  #     user = User.first
  #     visit edit_user_path(user.id)
  #     within('form') do 
  #       fill_in 'user[first_name]', with: 'changed'
  #       fill_in 'user[last_name]', with: ""
  #       fill_in 'user[email]', with: 'changed@email.com'
  #       fill_in 'user[password]', with: '123'
  #       fill_in 'user[password_confirmation]', with: '123'
  #     end
      
  #     click_button "Update User"
  #     expect(page).to have_content("Last name can't be blank")
  #   end
  # end
end
