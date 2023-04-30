class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!

  def index
  	@customers = Customer.page(params[:page]).per(10)
  end

  def edit
  	@customer = Customer.find(params[:id])
  end

  def update
  	@customer = Customer.find(params[:id])
  	if @customer.update(customer_params)
  		redirect_to admin_customer_path(@customer)
  	else
  		render "edit"
  	end
  end

  def show
     @customer = Customer.find(params[:id])
  end

  private

  def customer_params
  	params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end
end

# id	会員ID	◯		integer
# last_name	姓			string
# first_name	名			string
# last_name_kana	姓カナ			string
# first_name_kana	名カナ			string
# email	メールアドレス			string
# encrypted_password	パスワード			string
# postal_code	郵便番号			string
# address	住所			string
# telephone_number	電話番号			string
# is_deleted	会員ステータス			boolean
# created_at	登録日時			datetime
# updated_at	更新日時			datetime

# admin_customers GET    /admin/customers(.:format) admin/customers#index
# edit_admin_customer GET    /admin/customers/:id/edit(.:format) admin/customers#edit
# admin_customer GET    /admin/customers/:id(.:format) admin/customers#show
# PATCH  /admin/customers/:id(.:format) admin/customers#update
# PUT    /admin/customers/:id(.:format) admin/customers#update