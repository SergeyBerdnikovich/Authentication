class SessionController < ApplicationController

def first_auth
  user = User.authentication(params[:email_or_login], params[:password])
  respond_to  do |format|
    if user
      session[:user_id] = user.id
        code = user.create_code
        format.js { render :text => "#{code}" }
    else
        format.js { render :text => 'Error' }
    end
  end
end

def second_auth
  user = User.find(session[:user_id])
    respond_to  do |format|
      if user.activate!(params[:code])
         format.js { render :text => "active" }
      else 
         format.js { render :text => "not_activate" }
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
