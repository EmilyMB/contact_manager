require 'rails_helper'

describe 'the company view', type: :feature do
  describe 'phone numbers' do
    let(:company) { Company.create(name: "John & Co")}

    before(:each) do
      company.phone_numbers.create(number: "554-1234", contact_type: "Company")
      company.phone_numbers.create(number: "555-1245", contact_type: "Company")
      visit company_path(company)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    xit 'has a link to add a new phone number' do
      expect(page).to have_link("Add phone number", href: new_phone_number_path(contact_id: company.id, contact_type: "Company"))
    end

    xit 'adds a new phone number' do
      page.click_link("Add phone number")
      page.fill_in("Number", with: "555-9999")
      page.click_button("Create Phone number")
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("555-9999")
    end

    xit 'has links to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    xit 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in("Number", with: "555-0000")
      page.click_button("Update Phone number")
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content(old_number)
    end

    xit 'has links to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end
  end
end