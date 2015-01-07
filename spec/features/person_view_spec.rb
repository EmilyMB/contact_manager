require 'rails_helper'

describe 'the person view', type: :feature do

  describe 'view of email addresses' do
    let(:person) { Person.create(first_name: 'John', last_name: 'Doe')}

    before(:each) do
      person.email_addresses.create(address: "john@john.com")
      person.email_addresses.create(address: "john@johndoe.com")
      visit person_path(person)
    end

    it 'shows the email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_selector("li", text:"john@john.com")
      end
    end

    it 'has a link to add a new email address' do
      expect(page).to have_link("Add email address", href: new_email_address_path(person_id: person.id))
    end

    it 'adds a new email address' do
      page.click_link("Add email address")
      page.fill_in("Address", with: "bob@bob3.com")
      page.click_button("Create Email address")
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content("bob@bob3.com")
    end

    it 'has links to edit email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it 'edits an email address' do
      email = person.email_addresses.first
      old_email = email.address

      first(:link, 'edit').click
      page.fill_in("Address", with: "susy@susy.com")
      page.click_button("Update Email address")
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content(old_email)
    end

    it 'has links to delete email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end
  end

  describe 'view of phone numbers' do
    let(:person) { Person.create(first_name: 'John', last_name: 'Doe')}

    before(:each) do
      person.phone_numbers.create(number: "554-1234")
      person.phone_numbers.create(number: "555-1245")
      visit person_path(person)
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link("Add phone number", href: new_phone_number_path(person_id: person.id))
    end

    it 'adds a new phone number' do
      page.click_link("Add phone number")
      page.fill_in("Number", with: "555-9999")
      page.click_button("Create Phone number")
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content("555-9999")
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in("Number", with: "555-0000")
      page.click_button("Update Phone number")
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end
  end
end
