class TransfersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_wallet
  before_action :set_group

  def new
    @wallets = @wallet.group.wallets.where.not(id: @wallet.id).order(name: :asc)
    @goals = @wallet.group.goals.where.not(id: @wallet.id).order(name: :asc)
    @categories = @wallet.group.categories
    @payees = @wallet.group.members
    @tags = @wallet.group.tags
  end

  def create
    amount = Monetize.parse(transfer_params[:amount_cents])
    success = false

    # transfer_params[:category_id].present? ? "" : return

    if @wallet.type == "Wallet"
      if transfer_params[:wallet_id].present?
        receiver = Wallet.find(transfer_params[:wallet_id])
        success = handle_transfer(@wallet, receiver, amount)

      elsif transfer_params[:goal_id].present?
        receiver = Goal.find(transfer_params[:goal_id])
        success = handle_transfer(@wallet, receiver, amount)
      end

    elsif @wallet.type == "Goal"
      if transfer_params[:wallet_id].present?
        receiver = Wallet.find(transfer_params[:wallet_id])
        success = handle_transfer(@wallet, receiver, amount)

      elsif transfer_params[:goal_id].present?
        receiver = Goal.find(transfer_params[:goal_id])
        success = handle_transfer(@wallet, receiver, amount)
      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to @wallet.is_a?(Wallet) ? wallet_transactions_path(@wallet) : goal_path(@wallet), notice: "Transferência efetuada com sucesso!" }
      else
        @wallets = @wallet.group.wallets.where.not(id: @wallet.id).order(name: :asc)
        @goals = @wallet.group.goals.where.not(id: @wallet.id).order(name: :asc)
        @categories = @wallet.group.categories
        @payees = @wallet.group.members
        @tags = @wallet.group.tags
        format.html { render :new }
      end
    end
  end

  private

  def set_wallet
    @wallet = if params[:wallet_id].present?
      Wallet.find(params[:wallet_id])
    elsif params[:goal_id].present?
      Goal.find(params[:goal_id])
    end
  end

  def set_group
    @group = current_user.member.groups.joins(:base_wallets).find_by!(base_wallets: { id: @wallet.id })
  end

  def transfer_params
    params.require(:transfer).permit(:amount_cents, :category_id, :payer_id, :wallet_id, :goal_id, :description, tags: [], payees: [])
  end

  def handle_transfer(sender, receiver, amount)
    sender_params = transfer_params.except(:tags, :payees, :wallet_id, :goal_id)
    receiver_params = sender_params.dup

    sender_params.except(:category_id) if sender.is_a?(Goal)

    receiver_params.except(:category_id, :description, :payer_id) if receiver.is_a?(Goal)

    return false if receiver.is_a?(Wallet) && transfer_params[:category_id].blank?

    sender_tx = sender.transactions.new(
      sender_params.merge(amount_cents: amount.fractional, executed_at: Date.current, kind: 1)
    )

    receiver_tx = receiver.transactions.new(
      receiver_params.merge(amount_cents: amount.fractional, executed_at: Date.current, kind: 0)
    )

    if sender_tx.save && receiver_tx.save
      attach_tags_and_payees(sender_tx)
      attach_tags_and_payees(receiver_tx) if receiver.is_a?(Wallet)
      true
    else
      false
    end
  end

  def attach_tags_and_payees(transaction)
    transaction.tags << Tag.where(id: transfer_params[:tags]) if transfer_params[:tags].present?
    transaction.payees << Member.where(id: transfer_params[:payees]) if transfer_params[:payees].present?
  end

end
