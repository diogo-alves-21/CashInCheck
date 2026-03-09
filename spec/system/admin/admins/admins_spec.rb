require "rails_helper"

RSpec.describe "As a admin managing admins", type: :system do
  subject(:admin) { build :admin }
  let(:attributes_to_exclude) { [:id, :created_at, :updated_at, :password, :encrypted_password ] } # add ids to exclude

  let(:admin) { create(:admin) }
  before do
    login(admin, scope: :admin)
  end

  context "to check" do
    before do
      admin.save!
    end
    context "if side bar and menu index" do
      it "are acessible" do
        visit admin_root_path
        # find('span', text: I18n.t('lte.sidebar.__replace_with_button__')).click # click on nav section
        find("a[href='#{admin_admins_path}']").click
        expect(page.find("h3[data-test-title='#{Admin.model_name.human(count: 0)}']")).to have_content case_insensitive(Admin.model_name.human(count: 0))
        sleep(0.1)
        expect(current_path).to eq(admin_admins_path)
      end
    end

    context "if menu create" do
      it "is acessible" do
        visit admin_admins_path
        find("a[href='#{new_admin_admin_path}']").click
        expect(page.find("h3[data-test-title='#{Admin.model_name.human(count: 0)}']")).to have_content case_insensitive(Admin.model_name.human(count: 0))
        expect(page).to have_text I18n.t('views.mazer.action.new')
        expect(current_path).to eq(new_admin_admin_path)
      end
    end

    context "if menu edit" do
      it "is acessible" do
        visit admin_admins_path
        find("a[href='#{edit_admin_admin_path(id: admin.id)}']").click
        expect(page.find("h3[data-test-title='#{Admin.model_name.human(count: 0)}']")).to have_content case_insensitive(Admin.model_name.human(count: 0))
        expect(page).to have_text I18n.t('views.mazer.action.edit')
        expect(current_path).to eq(edit_admin_admin_path(id: admin.id))
      end
    end

    context "if menu show" do
      it "is acessible" do
        visit admin_admins_path
        find("a[href='#{admin_admin_path(id: admin.id)}']:not([data-turbo-method])").click
        expect(page.find("h3[data-test-title='#{Admin.model_name.human(count: 0)}']")).to have_content case_insensitive(Admin.model_name.human(count: 0))
        expect(page).to have_text I18n.t('views.mazer.action.show')
        expect(current_path).to eq(admin_admin_path(id: admin.id))
      end
    end
  end

  context "to create" do
    before do
      admin
      visit new_admin_admin_path
    end

    # uncomment and add required error
    # context "with an empty form" do
    #   it "is unable to create" do
    #     fill_form(:admin , :new, {})
    #     submit_form
    #     expect_to_be_in_toast(Admin.new.errors.add(:__attribute__, :__message__).full_message)
    #   end
    # end

    context "with attributes" do
      it "is able to create" do
        fill_form(:admin, admin.attributes.symbolize_keys.except(*attributes_to_exclude).compact_blank!)

        submit_form
        expect(page).to have_text I18n.t('views.mazer.action.show')

        expect_to_be_present_in_page(object: admin.attributes.symbolize_keys.except(*attributes_to_exclude))
        expect_to_be_in_toast(I18n.t('controllers.created', model: Admin.model_name.human(count: 1)))
      end
    end
  end

  context "to edit" do
    before do
      admin.save!
      visit edit_admin_admin_path(id: admin.id)
    end

    context "with all attributes" do
      it "is able to edit" do
        new_attributes = attributes_for(:admin)
        visit current_path

        fill_form(:admin, new_attributes.except(*attributes_to_exclude))

        submit_form
        expect_to_be_in_toast(I18n.t('controllers.updated', model: Admin.model_name.human(count: 1)))

        expect_to_be_present_in_page(object: Admin.find(admin.id).attributes.symbolize_keys.merge(new_attributes).except(*attributes_to_exclude))
      end
    end
  end
end
