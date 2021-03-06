#encoding: UTF-8
class AuthenticationsController < ApplicationController

	# Author:
    #  Mirna Yacout
    # Description:
    #  checks if the current_gamer already has an Authentication record
    # params
    #  none
    # Success:
    #  displays the correct view depending on the availability of Twitter authentication record
    #  in the Authentications table
    # Failure:
    #  none
	def twitter
	end

	# Author:
    #  Mirna Yacout
    # Description:
    #  Twitter callback method which saves the parameters given by Twitter upon the approval of
    #  the current user for the connection
    # params
    #     none
    # Success:
    #  checks if a record is in the Authentications table: if avaialable returns and redirect
    #  and if not creates a new record then redirect
    # Failure:
    #  none
	def twitter_callback
	  if I18n.locale == :en
	  	flash[:notice] = "Connected to Twitter successfully!"
	  else I18n.locale == :ar
	  	flash[:notice] = "تم التواصل مع تويتر بنجاح!"
	  end
	  auth = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_gid(auth["provider"],
       current_gamer.id) || Authentication.create_with_omniauth(auth,
        current_gamer)
      redirect_to "/gamers/edit"
      return
	end

	# Author:
    #  Mirna Yacout
    # Description:
    #  removes connection already in the table
    # params
    #     none
    # Success:
    #  finds connection record, removes it correctly and redirect
    # Failure:
    #  doesnot find the record
	def remove_twitter_connection
	  if I18n.locale == :en
	  	flash[:notice] = "Connection to Twitter removed successfully!"
	  else I18n.locale == :ar
	  	flash[:notice] = "تم إلغاء التواصل مع تويتر بنجاح!"
	  end
	  Authentication.remove_conn(current_gamer)
	  redirect_to "/gamers/edit"
	  return
	end

	# Author:
    #  Mirna Yacout
    # Description:
    #  Twitter callback with failure to connect to Twitter upon rejection or cancellation
    #  by the current_gamer himself or connection failure
    # params
    #  none
    # Success:
    #  redirect_to home page
    # Failure:
    #  none
	def twitter_failure
	  if I18n.locale == :en
	  	flash[:notice] = "Failed to connect to Twitter"
	  else I18n.locale == :ar
	  	flash[:notice] = "فشل التواصل مع تويتر بنجاح"
	  end
	  redirect_to root_url
	end

end
