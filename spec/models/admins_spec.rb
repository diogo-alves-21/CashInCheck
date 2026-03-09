require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject(:admin) { build :admin }

  context "Validations" do
    it "is valid with valid attributes" do
      expect(admin).to be_valid
    end
  end

  it "Update attributes" do
    admin.save!
    attributes_update = attributes_for(:admin).except(:id, :password)
    admin.update!(attributes_update)
    expect_to_be_present_in_model(object: admin, attributes: attributes_update)
  end

  it "Destroy" do
    admin.save!
    admin.destroy!
    expect(Admin.exists?(admin.id)).to eq(false)
  end
end
