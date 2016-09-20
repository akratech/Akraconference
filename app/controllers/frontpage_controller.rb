# -*- coding: utf-8 -*-
# This file is part of Mconf-Web, a web application that provides access
# to the Mconf webconferencing system. Copyright (C) 2010-2015 Mconf.
#
# This file is licensed under the Affero General Public License version
# 3 or later. See the LICENSE file.

class FrontpageController < ApplicationController

  layout false


  def show
    @spaces = Space.all.order('id DESC').limit 6
  end

  # Helper methods for devise
  # Without this, the registration form will have a nil `resource` when it's loaded,
  # which will make the labels wrong.
  helper_method :resource, :resource_name, :devise_mapping
  def resource_name
    :user
  end
  def resource
    @resource ||= User.new
  end
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def pricing
  end

  def contact_us
  end

  def get_in_touch
    if params["email"].present?
      if QueryMailer.get_in_touch(params["name"],params["email"],params["number"],params["message"]).deliver!
        flash[:notice] = "Thanks We will get back to you."
        redirect_to root_path
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def contact_us_mail
    form_params = params["jform"]
    if form_params["contact_email"].present?
      if QueryMailer.contact_us(form_params["contact_name"],form_params["contact_email"],form_params["contact_subject"],form_params["contact_message"]).deliver!
        flash[:notice] = "Thanks We will get back to you."
        redirect_to contact_us_path
      else
        render contact_us_path
      end
    else
      redirect_to contact_us_path
    end
  end


end
