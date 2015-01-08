require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
  let(:email_address) { EmailAddress.new(address: "bob@bob.com", contact_id: 1, contact_id: "Person")}

  it 'is valid' do
    expect(email_address).to be_valid
  end

  it "is not valid without an email" do
    email_address.address = nil
    expect(email_address).not_to be_valid
  end

  it "is not valid without a contact_id" do
    email_address.contact_id = nil
    expect(email_address).not_to be_valid
  end

  it 'is associated with a contact' do
    expect(email_address).to respond_to(:contact)
  end
end
