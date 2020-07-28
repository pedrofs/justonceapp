# frozen_string_literal: true

class ApplicationController < ActionController::Base
  set_current_tenant_through_filter

  before_action :set_tenant

  rescue_from Pundit::NotAuthorizedError, with: :access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def set_tenant
    set_current_tenant(Home.first)
  end

  def event_store
    Rails.configuration.event_store
  end

  def command_bus
    Rails.configuration.command_bus
  end

  def access_denied
    redirect_to '/401.html'
  end

  def not_found
    redirect_to '/404.html'
  end
end
