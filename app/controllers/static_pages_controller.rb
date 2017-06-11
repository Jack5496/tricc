class StaticPagesController < ApplicationController

  def call_controller_post_method()
        controller_name = params[:controller_name]
        method_name = params[:method_name]
        custom = params[:custom]
      
        result = StaticPagesController.call_controller_method(controller_name,method_name,custom)
        
        redirect_to controller: 'static_pages', action: 'admin_menu', sql_result: result
        
        #redirect_to request.referrer || root_url
  end

  def call_controller_method()
        controller_name = params[:controller_name]
        method_name = params[:method_name]
        custom = params[:custom]
      
        return StaticPagesController.call_controller_method(controller_name,method_name,custom)
        
        #redirect_to request.referrer || root_url
  end
  
  def self.call_controller_method(controller_name,method_name,custom)
        controller = (controller_name + 'Controller').constantize
        
        meth = controller.method(method_name)
        
        return meth.call(custom)
  end
  
  def self.sql(query)
    sql = query.to_s
    records_array = ActiveRecord::Base.connection.execute(sql)
    result = records_array
    
    return result
  end



  def home
    if logged_in?
      
    else
      redirect_to '/login'
    end
  end

  def help
  end
  
  def admin_menu
  end

  def about
  end
  
  def contact
  end
end
