# frozen_string_literal: true
class OpenApiSyncTransactions < ApplicationJob

  sidekiq_options retry: 15, backtrace: true

  sidekiq_retry_in do |count|
    2 ** (count + 1)
  end

  def perform(wallet_id = nil)
    if wallet_id
      wallet = Wallet.find(wallet_id)
      return unless wallet.api_access_token.present?
      sync_wallet(wallet)
    else
      Wallet.where.not(api_access_token: nil, account_id: nil).find_each do |wallet|
        sync_wallet(wallet)
      end
    end
  end

  def sync_wallet(wallet)
    account = Openapi::OpenApiService.new.get_account(wallet.account_id)
    transactions = fetch_transactions(account)
    puts transactions.pretty_inspect
    process_transactions(wallet, transactions)
  end

  def fetch_transactions(account)
    #start_date = (Date.current - 5).to_s
    #end_date = Date.current.to_s

    utc_today  = Time.now.utc.to_date
    start_date = (utc_today - 100).to_s
    end_date   = utc_today.to_s

    Openapi::OpenApiService.new.get_account_transactions(account, start_date, end_date)
  end

  def process_transactions(wallet, api_transactions)
    return unless api_transactions.present?

    group = wallet.group

    booked_transactions = api_transactions.dig("transactions", "booked") || []

    booked_transactions.each do |api_transaction|

      merchant_entity_id = api_transaction["creditorName"].to_s.gsub(/\s+/, "").downcase.presence ||
        api_transaction["debtorName"].to_s.gsub(/\s+/, "").presence ||
        api_transaction["remittanceInformationUnstructured"].to_s.gsub(/\s+/, "").presence

      amount = api_transaction["transactionAmount"]["amount"]

      # PASSAR O CAMPO DA INFO EM VEZ DO ENTITY_ID
      entity = map_category(merchant_entity_id, group)
      entity_tag = map_tags(merchant_entity_id, group)

      kind = map_transaction_kind(amount)
      amount_cents = Monetize.parse(amount).fractional

      transaction_id = api_transaction["transactionId"] || api_transaction["internalTransactionId"]

      transaction = wallet.transactions.find_or_create_by(api_transaction_id: transaction_id) do |t|
        t.amount_cents = kind == 1 ? amount_cents * -1 : amount_cents
        t.executed_at = api_transaction["valueDate"]
        t.kind = kind
        t.description = ""
        t.amount_currency = api_transaction["transactionAmount"]["currency"]
        t.api_transaction_id = transaction_id
        t.category_id = entity.category.id
        t.entity_id = entity.api_entity_id
        t.wallet_id = wallet.id
        t.from_api = true

        creditor_name = api_transaction["creditorName"]
        debtor_name   = api_transaction["debtorName"]
        remittance    = api_transaction["remittanceInformationUnstructured"]

        t.description = remittance if debtor_name.present?
        t.entity_name =
          if creditor_name.present? && remittance.present?
            creditor_name
          elsif debtor_name.present?
            debtor_name
          elsif remittance.present?
            remittance
          end

        wallet.group.group_members.includes(:member).each do |group_member|
          if group_member.owner? && !group_member.member.user.nil?
            t.payer_id = group_member.member.id
          end
        end
      end
      transaction.tags << entity_tag.tag unless transaction.tag_transactions.exists?
      map_payees(wallet, transaction)
    end
  end

  def map_category(merchant_entity_id, group)
    EntityCategory.find_or_create_by(api_entity_id: merchant_entity_id, group_id: group.id) do |ec|
      ec.category = Category.create!(group: group, name: "Por definir")
    end
  end

  def map_tags(merchant_entity_id, group)
    EntityTag.find_or_create_by(api_entity_id: merchant_entity_id, group_id: group.id) do |et|
      et.tag = Tag.create!(group: group, name: "novatag")
    end
  end

  def map_transaction_kind(amount)
    amount.to_f > 0 ? 0 : 1
  end

  def map_payees(wallet, transaction)
    default_payees = wallet.group.members.to_a
    current_payees = transaction.payees.to_a

    if current_payees.empty? ||
      (current_payees.map(&:id).sort == default_payees.map(&:id).sort)

      default_payees.each do |member|
        transaction.payees << member unless transaction.payees.include?(member)
      end
    end
  end
end

