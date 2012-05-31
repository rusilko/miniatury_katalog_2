require 'spec_helper'

describe "StaticPages" do

  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title))}
  end

  let(:base_title) { "Katalog Miniatur |" }

  describe "Home page" do
    before { visit root_path } 
    let(:heading)    { 'Katalog Miniatur' }
    let(:page_title) { 'Home' }
    it_should_behave_like "all static pages"

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end

  end
  
  describe "About page" do
    before { visit about_path } # same as visit '/about (which in turn maps to '/static_pages/about')
    let(:heading)    { 'Katalog Miniatur' }
    let(:page_title) { 'About' }
    it_should_behave_like "all static pages"
    
  end

  describe "Contact page" do
    before { visit contact_path } 
    let(:heading)    { 'Katalog Miniatur' }
    let(:page_title) { 'Contact' }
    it_should_behave_like "all static pages"    
  end

  describe "Help page" do #different style, more verbose left for reference

    it "should have the content 'Katalog Miniatur: Pomoc'" do
      visit help_path
      page.should have_content('Katalog Miniatur: Pomoc')
    end

    it "should have the right title" do
      visit help_path
      page.should have_selector('title', text: "#{base_title} Help")
    end
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')

    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')

    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')

    click_link "Home"
    page.should have_selector 'title', text: full_title('Home')

    click_link "Sign in!"
    page.should have_selector 'title', text: full_title('Sign in')
  end

end
