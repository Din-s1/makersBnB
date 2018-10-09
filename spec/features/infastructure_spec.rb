require 'pg'

feature 'Basic Infastructure Test' do
  scenario 'Show "Hello, World"' do
    visit '/'
    expect(page).to have_content('Hello, World!');
  end  
end
