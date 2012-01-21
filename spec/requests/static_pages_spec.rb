require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do

    it "should have the content 'Katalog Miniatur'" do
      visit '/static_pages/home'
      page.should have_content('Katalog Miniatur')
    end

  end

  describe "About page" do

    it "should have the content 'Katalog Miniatur: About'" do
      visit '/static_pages/about'
      page.should have_content('Katalog Miniatur: About')
    end

  end

  describe "Contact page" do

    it "should have the content 'Katalog Miniatur: Kontakt'" do
      visit '/static_pages/contact'
      page.should have_content('Katalog Miniatur: Kontakt')
    end

  end

  describe "Help page" do

    it "should have the content 'Katalog Miniatur: Pomoc'" do
      visit '/static_pages/help'
      page.should have_content('Katalog Miniatur: Pomoc')
    end

  end
end
