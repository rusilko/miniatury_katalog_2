# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  let(:attr) { { name: "Example User", email: "user@example.com" } }

  it "should create a new instance given valid attributes" do
    User.create!(attr)
  end

  it "should require a name" do
    u = User.new(attr.merge name: "")
    u.should_not be_valid
  end

  it "should require an email" do
    u = User.new(attr.merge email: "")
    u.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    u = User.new(attr.merge name: long_name)
    u.should_not be_valid
  end

  it "should reject names that are too short" do
    short_name = "a" * 2
    u = User.new(attr.merge name: short_name)
    u.should_not be_valid
  end

  it "should reject invalid email address" do
    addresses = %w[ user@foo,com user_at_foo.org user@foo. ]
    addresses.each do |a|
      u = User.new(attr.merge email: a)
      u.should_not be_valid
    end
  end

  it "should accept valid email address" do
    addresses = %w[ user@foo.com USER@foo.org first.last@foo.jp ]
    addresses.each do |a|
      u = User.new(attr.merge email: a)
      u.should be_valid
    end
  end

  it "should reject duplicate email addresses" do
    u1 = User.create!(attr)
    u2 = User.new(attr)
    u2.should_not be_valid
  end

  it "should reject duplicate email addresses up to case" do
    email = "tomek@gmail.com"
    u1 = User.create!(attr.merge email: email)
    u2 = User.new(attr.merge email: email.upcase)
    u2.should_not be_valid
  end
    
end
