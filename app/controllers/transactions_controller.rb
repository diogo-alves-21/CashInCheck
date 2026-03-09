class TransactionsController < ApplicationController

  before_action :set_wallet
  before_action :set_group

  include TransactionsConcern

  def index
    @categories = @wallet.group.categories.all
    @tags = @wallet.group.tags.all

    @currency = @wallet.currency

    @transactions = get_wallet_transactions(@wallet)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @categories = @wallet.group.categories
    @payees = @wallet.group.members
    @tags = @wallet.group.tags
  end

  def edit
    @transaction = Transaction.find(params[:id])
    @categories = @wallet.group.categories
    @payees = @wallet.group.members
    @tags = @wallet.group.tags
  end

  def create
    amount = Monetize.parse(transaction_params[:amount_cents])

    # transaction_params[:category_id].present? ? "" : return

    @transaction = @wallet.transactions.new(
      transaction_params
        .except(:tags, :payees)
        .merge(amount_cents: amount.fractional)
    )
    if @transaction.save
      @transaction.tags << Tag.where(id: transaction_params[:tags]) if transaction_params[:tags].present?
      @transaction.payees << Member.where(id: transaction_params[:payees]) if transaction_params[:payees].present?

      redirect_to wallet_transactions_path, notice: "Transação criada com sucesso!"
    else
      @categories = @wallet.group.categories
      @payees = @wallet.group.members
      @tags = @wallet.group.tags
      render :new
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    # transaction_params[:category_id].present? ? "" : return

    amount = Monetize.parse(transaction_params[:amount_cents])

    @transaction.assign_attributes(
      transaction_params
        .except(:tags, :payees)
        .merge(amount_cents: amount.fractional)
    )

    if @transaction.save

      if transaction_params[:tags]
        tags = transaction_params[:tags].reject(&:blank?)
        @transaction.tags = tags.present? ? Tag.where(id: tags) : @transaction.tags
      end

      if transaction_params[:payees]
        payees = transaction_params[:payees].reject(&:blank?)
        @transaction.payees = payees.present? ? Member.where(id: payees) : @transaction.payees
      end

      redirect_to wallet_transactions_path(@wallet), notice: "Transação atualizada com sucesso!"
    else
      @categories = @wallet.group.categories
      @payees = @wallet.group.members
      @tags = @wallet.group.tags
      render :edit
    end
  end

  def destroy
    transaction = Transaction.find(params[:id])
    transaction.tags.clear
    transaction.payees.clear
    transaction.destroy
    redirect_to wallet_transactions_path, notice: "Transação apagada com sucesso!"
  end

  def add_tag
    @transaction = Transaction.find(params[:id])
    group = @transaction.base_wallet.group
    name = params[:name].to_s.strip

    return redirect_back(fallback_location: wallet_transaction_path, alert: "Por favor, informe um nome de uma tag.") if name.blank?

    normalized_name = name.strip.downcase.delete(" ")
    puts "Normalized Name: #{normalized_name}"
    tag = group.tags.where("LOWER(REPLACE(name, ' ', '')) = ?", normalized_name).first_or_create!(name: normalized_name)

    if @transaction.tags.exists?(tag.id)
      flash[:alert] = "A tag ‘#{tag.name}’ já está associada a esta transação."
    else
      @transaction.tags << tag
      flash[:notice] = "Tag ‘#{tag.name}’ adicionada com sucesso."
    end

    redirect_to wallet_transaction_path(@transaction.base_wallet, @transaction)
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

  def set_group
    @group = current_user.member.groups.joins(:wallets).find_by!(wallets: { id: @wallet.id })
  end

  def transaction_params
    params.require(:transaction).permit(:amount_cents, :category_id, :payer_id, :description, :kind, :executed_at, tags: [], payees: [])
  end

end
