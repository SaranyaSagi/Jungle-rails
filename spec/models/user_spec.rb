require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    
    # it 'should validate all fields are true' do
    #   @user = User.new(name: 'Gwen Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
    #   #expect(@user).not_to be_valid # can use just this
    #   @user.valid?
    #   expect(@user.errors).not_to include("can't be blank")
    # end

    it 'should validate all fields are true' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      #expect(@user).not_to be_valid # can use just this
      @user.valid?
      expect(@user.errors).not_to include("can't be blank")
    end

    it 'should validate first name field' do
      @user = User.new(last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      #expect(@user).not_to be_valid # can use just this
      @user.valid?
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it 'should validate last_name field' do
      @user = User.new(first_name: 'Gwen', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      #expect(@user).not_to be_valid #can use just this
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank")
    end 

    it 'should validate email field' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      #expect(@user).not_to be_valid
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'should check if user email is unique' do
      @user1 = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      @user1.save
      @user2 = User.new(first_name: 'peter', last_name: 'parker' , email: 'SPIDERMAN@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      @user2.valid?
      expect(@user2.errors[:email]).to include("has already been taken")
    end

    it 'should validate password field' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com')
      #expect(@user).not_to be_valid
      @user.valid?
      expect(@user.errors[:password_digest]).to include("can't be blank")
    end

    it 'should check if password and password confirmation do match' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderwweb')
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should validate/check if the password is too short' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'webby', password_confirmation: 'webby')
      @user.valid?
      expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'should save/log user if credentials are valid' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      @user.save!
      expect(User.authenticate_with_credentials('spiderman@test.com', 'spiderWeb')).to be_present
    end

    it 'should not log user if email is incorrect/not same as saved' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      @user.save!
      expect(User.authenticate_with_credentials('spiderman3@test.com', 'spiderWeb')).not_to be_present # not_to be present because wrong email
    end

    it 'should not log user if password is incorrect/not same as saved' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      @user.save!
      expect(User.authenticate_with_credentials('spiderman@test.com', 'spiderWebby')).not_to be_present # not_to be present because wrong password
    end

    it 'should log user in even when there are few spaces before/after email address' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      @user.save!
      expect(User.authenticate_with_credentials('  spiderman@test.com  ', 'spiderWeb')).to be_present
    end

    it 'should log user in even when email has different case compared to saved' do
      @user = User.new(first_name: 'Gwen', last_name: 'Stacy', email: 'spiderman@test.com', password: 'spiderWeb', password_confirmation: 'spiderWeb')
      @user.save!
      expect(User.authenticate_with_credentials('SPIDERMAN@test.com', 'spiderWeb')).to be_present
    end
  end

end
