class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception



  #choose locale based on subdomain (en.domain.com) , or browser lang
  include Localization
  before_action :set_locale

  #layout false for AJAX
  layout :choose_layout
  def choose_layout
    if show_layout?
      'application'
    else
      false
    end
  end
  def show_layout?
    !request.xhr?
  end

#assets hashed by webpack
  include WebpackAssets
  before_action :assets_hash
  helper_method :script_for
  helper_method :style_for

end
