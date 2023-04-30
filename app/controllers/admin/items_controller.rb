class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!

  def index
  	@items = Item.page(params[:page]).per(10)
  end

  def show
  	@item = Item.find(params[:id])
  end

  def new
  	@item = Item.new
  end

  def create
  	@item = Item.new(item_params)
  	if @item.save
  	   redirect_to admin_item_path(@item)
  	else
  	   render "new"
  	end
  end

  def edit
  	@item = Item.find(params[:id])
  end

  def update
  	@item = Item.find(params[:id])
  	if @item.update(item_params)
  	  redirect_to admin_item_path(@item.id)
  	else
  		render "edit"
  	end
  end


  private

  def item_params
  	params.require(:item).permit(:name,:item_image,:introduction,:price,:is_active)
  end

end


# id	商品ID
# genre_id	ジャンルID
# name	商品名
# image_id	商品画像ID
# introduction	商品説明文
# price	税抜き価格
# is_active	販売ステータス
# created_at	登録日時
# updated_at	更新日時


# admin_items GET index
# admin/items POST index
# admin/items create
# new_admin_item GET new
# edit_admin_item GET edit
# admin_item GET show
            # PATCH  /admin/items/:id(.:format) admin/items#update
            # PUT    /admin/items/:id(.:format) admin/items#update