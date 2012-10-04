class SessionController < ApplicationController

def first_auth
  user = User.authentication(params[:email_or_login], params[:password])
  respond_to  do |format| 
    if user
      session[:user_id] = user.id
      if user.two_step_auth == true       
        code = user.create_code
        format.js { render :text => "#{code}" }
      else 
        user.simple_activate!
        format.js  
      end
    else
        format.js { render :text => 'Error' }
    end
  end
end

def second_auth
  user = User.find(session[:user_id])
    respond_to  do |format|
      if user.activate!(params[:code])
        format.js 
      else 
        flash[:notice] = 'Code is not correct or 30 sec losted'
        format.js 
      end
    end
end


def destroy
  user = User.find(session[:user_id])
  user.deactivate!
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end
end
