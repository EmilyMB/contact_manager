require 'rails_helper'

RSpec.describe Company, :type => :model do
  let(:company) { Company.new(name: "bob's company")}

  it 'is valid' do
    expect(company).to be_valid
  end

  it "is not valid without a name" do
    company.name = nil
    expect(company).not_to be_valid
  end
end
