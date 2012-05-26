require 'spec_helper'

describe "separated admin tests" do
  
  subject { page }

  describe "delete links" do
    
    #it { should_not have_link('delete') }

    describe "as admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
     
      before do
        sign_in admin
        visit users_path

        # @user = User.new(name: "Example User", email:"user@example.com", password: "foobar", password_confirmation: "foobar")
        # @user.toggle!(:admin)
        # sign_in @user
      
      binding.pry          
      end

      it { should have_link('delete', href: user_path(User.first)) }

      # it "should be able to delete another user" do
      #   expect { click_link('delete') }.to change(User, :count).by(-1)
      # end

     # it { should_not have_link('delete', href: user_path(admin)) }
     
    end
  end
end