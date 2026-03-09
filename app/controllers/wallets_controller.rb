class WalletsController < ApplicationController

  before_action :set_group, only: [:index, :show, :edit, :update, :destroy]
  before_action :openapi_service
  def index
    if @group
      @wallets = @group.wallets.order(name: :asc)
      @wallets_by_group = { @group => @wallets }
    else
      @wallets = Wallet.includes(:group).where(group: current_user.member.groups).order(name: :asc)
      @wallets_by_group = @wallets.group_by(&:group)
    end

    format = I18n.t :format, scope: 'number.currency.format'
    @wallets_balance_cents = @wallets.sum(:balance_cents)
    @wallets_total = Money.from_cents(@wallets_balance_cents, @wallets.first.currency).format(format: format)

    respond_to do |format|
      format.html
      format.json do
        render json: @wallets.pluck(:id, :name).map { |id, name| { id: id, name: name } }
      end
    end
  end

  def show
    @wallet = Wallet.find(params[:id])
  end

  def new
    @groups = current_user.member.groups
  end

  def edit
    @wallet = Wallet.find(params[:id])
    @groups = current_user.member.groups
  end

  def create
    @wallet = Wallet.new(wallet_params)
    puts @wallet.inspect
    if @wallet.save
      redirect_to new_info_wallet_path(@wallet), notice: "Wallet criada com sucesso!"
    else
      @groups = current_user.member.groups
      render :new
    end
  end

  def update
    return unless wallet_params[:name].present?

    @wallet = Wallet.find(params[:id])
    if @wallet.update(wallet_params)
      redirect_to wallets_path, notice: "Wallet editada com sucesso!"
    else
      render(:edit)
    end
  end

  def destroy
    wallet = Wallet.find(params[:id])
    wallet.destroy
    redirect_to wallet_path, notice: "Wallet apagada com sucesso!"
  end

  def new_info
    @wallet = Wallet.find(params[:id])
  end

  def new_bank_choice
    @wallet = Wallet.find(params[:id])

    @institutions = @service.get_banks('PT')
  end

  def exchange_public_token
    wallet = Wallet.find(params[:id])

    # service = Openapi::OpenApiService.new
    # req = @service.create_requisition(params.require(:institution), wallet)
    req = @service.create_requisition('SANDBOXFINANCE_SFIN0000', wallet)
    return unless wallet.update(api_access_token: req["id"])

    redirect_to req["link"], allow_other_host: true, status: :see_other
  end

  def account_selection
    @wallet = Wallet.find(params[:id])
    @accounts = @service.get_accounts(@wallet.api_access_token)
  end

  def select_account
    wallet = Wallet.find(params[:id])
    @service.get_account(params.require(:account))

    if wallet.update(account_id: params.require(:account))
      redirect_to wallets_path, notice: "Conta ligada com sucesso!"
    else
      redirect_to wallets_path, alert: "Não foi possível conectar a sua conta"
    end
  end

  def disconnect_wallet
    wallet = Wallet.find(params[:id])
    @service.destroy_requisition(wallet.api_access_token)

    Wallet.transaction do
      wallet.update!(api_access_token: nil, account_id: nil)
    end
    redirect_to edit_wallet_path(wallet), notice: "Wallet desconectada com sucesso!"
  end

  private

  def openapi_service
    @service = Openapi::OpenApiService.new
    @service.generate_token!
  end

  def set_group
    if params[:group_id]
      @group = current_user.member.groups.find(params[:group_id])
    elsif params[:id]
      @group = current_user.member.groups.joins(:wallets).find_by!(wallets: { id: params[:id] })
    end
  end

  def wallet_params
    params.require(:wallet).permit(:name, :group_id, :description, :api_access_token)
  end

  def transfer_params
    params.require(:transaction).permit(:amount_cents, :category_id, :payer_id, :wallet_id, :description, tags: [], payees: [])
  end

end
