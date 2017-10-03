class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  include ActionView::Helpers::OutputSafetyHelper
  include Cms::Helpers::ImageHelper
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include Cms::Helpers::UrlHelper
  include Cms::Helpers::PagesHelper
  include Cms::Helpers::MetaDataHelper
  include Cms::Helpers::NavigationHelper
  include Cms::Helpers::ActionView::UrlHelper
  include Cms::Helpers::Breadcrumbs
  include ActionControllerExtensions::InstanceMethods
  include ApplicationHelper
  include Cms::Helpers::AnotherFormsHelper
  include Cms::Helpers::TagsHelper

  reload_rails_admin_config

  def root_without_locale
    redirect_to root_path(locale: I18n.locale)
  end

  def render_not_found
    @render_footer = false
    render template: "errors/not_found.html.slim", status: 404, layout: "application"
  end
end
