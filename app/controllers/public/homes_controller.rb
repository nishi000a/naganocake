class Public::HomesController < ApplicationController
  def top
    @items = Item.limit(8).offset(4)
  end

  def about
  end

end
