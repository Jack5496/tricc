class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @answer  = current_user.answers.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      redirect_to '/login'
    end
  end

  def help
  end
  
  def activ_game
    
  end

  def about
  end
  
  def contact
  end
end
