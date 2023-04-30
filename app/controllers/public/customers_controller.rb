class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
  end

  def unsubscribe
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
       flash[:success] = "個人情報を編集しました"
       redirect_to customers_path
    else
        flash[:danger] = '個人情報の編集に失敗しました'
        render :edit
    end
  end

  def withdraw
  end

  def destroy
    current_customer.update(is_deleted: true)
    reset_session
    flash[:success] = "アカウントを削除しました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number, :postal_code, :address)
  end

end






                      #     edit_customers GET    /customers/edit(.:format)                                                                         public/customers#edit
                      #         customers GET    /customers(.:format)                                                                              public/customers#show
                      #                   PATCH  /customers(.:format)                                                                              public/customers#update
                      #                   PUT    /customers(.:format)                                                                              public/customers#update
                      # customers_withdraw PATCH  /customers/withdraw(.:format)                                                                     public/customers#destroy
                      #                   GET    /customers/withdraw(.:format)                                                                     public/customers#withdraw