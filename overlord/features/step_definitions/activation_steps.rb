Given(/^The bomb has not been initialized$/) do
  @bomb = nil
end

Given(/^The bomb has been initialized$/) do
  visit('/')
  page.find('#initialize').click
end

Given(/^the bomb has been activated$/) do
  visit('/')
  fill_in('actcode', :with=>'1234')
  page.find('#activate').click 
end

Given(/^the bomb has been initialized with activation code "(.*?)"$/) do |code|
  visit('/')
  fill_in('actcode', :with=>code)
  page.find('#initialize').click
end

Given(/^the bomb has been initialized with deactivation code "(.*?)"$/) do |code|
  visit('/')
  fill_in('deactcode', :with=>code)
  page.find('#initialize').click
end