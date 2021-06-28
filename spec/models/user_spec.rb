require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "creates user if fields are valid" do
      @user = User.create(name: "Tandica", email: "jungle@test.ca", password: "cupcake", password_confirmation: "cupcake")
      expect(@user).to be_valid
    end

    it "is not valid if passwords do not match" do
      @user = User.create(name: "Tandica", email: "jungle@test.ca", password: "cupcake", password_confirmation: "cake")
      expect(@user).to_not be_valid
    end

    it "is valid when emails are unique" do
      @user1 = User.create(name: "Tandica", email: "jungle-tandica@test.ca", password: "cupcake", password_confirmation: "cupcake")
      @user1.save
      @user2 = User.create(name: "Tandica", email: "jungle-tandica@test.ca", password: "cupcake", password_confirmation: "cupcake")
      @user2.save
      expect(@user2).to_not be_valid
    end

    it "is valid if name is present" do
      @user = User.create(name: "", email: "jungle@test.ca", password: "cupcake", password_confirmation: "cake")
      expect(@user).to_not be_valid
    end

    it "is valid if email is present" do
      @user = User.create(name: "Tandica", email: nil, password: "cupcake", password_confirmation: "cake")
      expect(@user).to_not be_valid
    end

    it "is valid if password is more than 7 characters" do
      @user = User.create(name: "Tandica", email: "jungle@test.ca", password: "cupcak", password_confirmation: "cake")
      expect(@user).to_not be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    it "is valid with credentials" do 
      @user = User.create(name: "Tandica", email: "jungle@test.ca", password: "cupcake", password_confirmation: "cupcake")
      @user.save
      loggedIn = User.authenticate_with_credentials(@user.email, @user.password)
      expect(loggedIn.id).to be (@user.id)
    end

    it "ignores whitespace" do 
      @user = User.create(name: "Tandica", email: "jungle@test.ca", password: "cupcake", password_confirmation: "cupcake")
      @user.save
      loggedIn = User.authenticate_with_credentials("   jungle@test.ca ", @user.password)
      expect(loggedIn.id).to be (@user.id)
    end

    it "ignores input with different cases" do 
      @user = User.create(name: "Tandica", email: "jungle@test.ca", password: "cupcake", password_confirmation: "cupcake")
      @user.save
      loggedIn = User.authenticate_with_credentials("jUnGle@test.ca", @user.password)
      expect(loggedIn.id).to be (@user.id)
    end
  end 
end
