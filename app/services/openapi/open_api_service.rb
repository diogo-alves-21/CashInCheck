module Openapi
  class OpenApiService
    def initialize
      @token_data = nil
    end

    def generate_token!
      NordigenClient.generate_token()
    end

    def get_banks(country_code)
      NordigenClient.institution.get_institutions(country_code)
    end

    def create_requisition(institution_id, wallet)
      NordigenClient.init_session(
        redirect_url: "http://localhost:3000/wallets/#{wallet.id}/account_selection",
        institution_id: institution_id,
        reference_id: SecureRandom.uuid,
        user_language: 'pt',
        )
    end

    def destroy_requisition(requisition_id)
      NordigenClient.requisition.delete_requisition(requisition_id)
    end

    def get_accounts(requisition_id)
      account_metadata = []
      requisition_data = NordigenClient.requisition.get_requisition_by_id(requisition_id)

      requisition_data["accounts"].map do |account_id|

        metadata = NordigenClient.account(account_id).get_metadata()
        puts "Metadata: #{metadata}"
        account_metadata << metadata
      end
      account_metadata
    end

    def get_account(account_id)
      ensure_token!
      NordigenClient.account(account_id)
    end

    def get_account_balances(account_id)
      NordigenClient.account(account_id).get_balances()
    end

    def get_account_transactions(account, start_date, end_date)
      ensure_token!
      account.get_transactions(date_from: start_date, date_to: end_date)
    end

    def ensure_token!
      generate_token! unless @token_data
    end
  end
end
