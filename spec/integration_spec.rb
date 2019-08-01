require('rspec')
require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)




describe('take atrip to the libary', {:type => :feature}) do
  it('adds a book') do
    visit('/')
    click_on('Catalog')
    fill_in('book_title', :with => 'Jacques Cousteau Undersea Adventures!')
    fill_in('book_desc', :with => 'This is our test description')
    click_on('Add Book')
    expect(page).to have_content('Jacques Cousteau Undersea Adventures!')
  end

  it('clicks on a book to check out a cool description')do
  visit('/')
  click_on('Catalog')
  fill_in('book_title', :with => 'Jacques Cousteau Undersea Adventures!')
  fill_in('book_desc', :with => 'This is our test description')
  click_on('Add Book')
  expect(page).to have_content('Jacques Cousteau Undersea Adventures!')
  visit('/catalog/Jacques%20Cousteau%20Undersea%20Adventures!')
  expect(page).to have_content('This is our test description')
  end
end
