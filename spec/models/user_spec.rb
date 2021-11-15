require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    before do
      @user = User.new
    end

    it 'creating User Successfully if no validation error' do
      @new_user = User.new(first_name: "Alice", last_name: "Ac", email: "Alice@gmail.com", password: "password", password_confirmation: "password")
      @new_user.save!
      expect(@new_user).to be_persisted
    end

    it 'is invalid without a first_name' do
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:first_name]).to include('can\'t be blank')
    end

    it 'is invalid without a last_name' do
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:last_name]).to include('can\'t be blank')
    end

    it 'is invalid without email' do 
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:email]).to include('can\'t be blank')
    end
    it 'is invalid without password' do 
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password]).to include('can\'t be blank')
    end

    it 'is invalid if password and password_confirmation didn\'t match' do
      @user3 = User.new(first_name: "John", last_name: "Ac", email: "test32@gmail.com", password: "password", password_confirmation: "pasaasd")
      @user3.save
      expect(@user3).to_not be_valid
      expect(@user3.errors.messages[:password_confirmation]).to include('doesn\'t match Password')
    end

    it 'is invalid short passwords' do
      @first_user = User.new(first_name: "John", last_name: "Ac", email: "test32@gmail.com", password: "pass", password_confirmation: "pass")
      @first_user.save
      expect(@first_user).to_not be_valid
      expect(@first_user.errors.messages[:password]).to include('is too short (minimum is 6 characters)')
    end

    it 'only allowed unique emails' do
      @user1 = User.new(first_name: "John", last_name: "Ac", email: "test@gmail.com", password: "password", password_confirmation: "password")

      @user2 = User.new(first_name: "John", last_name: "Ac", email: "Test@gmail.com", password: "password", password_confirmation: "password")
      @user1.save
      @user2.save

      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.messages[:email]).to include('has already been taken')

    end
  end


  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "return nil with nil email and password" do
      expect(User.authenticate_with_credentials(nil, nil)).to eq(nil)
    end

    it "return nil with valid email and nil password" do
      User.new(
        first_name:            "New",
        last_name:             "User",
        email:                 "test@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save
      expect(User.authenticate_with_credentials("test@mail.com", nil)).to eq(nil)
    end

    it 'return user with valid email and password' do 
      User.new(
        first_name:            "New",
        last_name:             "User",
        email:                 "test@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save

      validated_user = User.authenticate_with_credentials("test@mail.com", "password")
      expect(validated_user.email).to eq("test@mail.com")
    end

    it "return a user with valid email and password case insensitive" do
      User.new(
        first_name:            "New",
        last_name:             "User",
        email:                 "test@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save

      user = User.authenticate_with_credentials("TeST@Mail.com", "password")
      expect(user.email).to eq("test@mail.com")
    end

    it "return a user with valid email and password case insensitive with leading spaces" do
      User.new(
        first_name:            "New",
        last_name:             "User",
        email:                 "test@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save

      user = User.authenticate_with_credentials("   TeST@Mail.com", "password")
      expect(user.email).to eq("test@mail.com")
    end

    it "return a user with valid email and password case insensitive with leading and trailing spaces" do
      User.new(
        first_name:            "New",
        last_name:             "User",
        email:                 "test@mail.com",
        password:              "password",
        password_confirmation: "password"
      ).save

      user = User.authenticate_with_credentials("   TeST@Mail.com"   , "password")
      expect(user.email).to eq("test@mail.com")
    end

  end
end
