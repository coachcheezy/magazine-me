class Api::ApiController < ApplicationController
  
  before_filter :validate_and_set_format, :restrict_access #, :increment_uses
  
  FORMATS = ['json']
  
  def restrict_access 
    return render_jsend_fail :api_key => 'api_key is required' unless params[:api_key]
    @api_key = ApiKey.find_by_access_token(params[:api_key])
    render(:text => 'API key not found', :status => :bad_request) and return if @api_key.nil?
  end
  private :restrict_access
  
  def validate_and_set_key
    return render_jsend_fail :api_key => 'api_key is required' unless params[:api_key]
    @key = Key.find_by_uuid(params[:api_key])
    render(:text => 'API key not found', :status => :bad_request) and return if @key.nil?
    render(:text => 'API key expired', :status => :bad_request) and return unless @key.is_enabled?
    render(:text => 'API key exceeds rate limit', :status => :bad_request) and return if @key.exceeds_rate_limit?
  end
  private :validate_and_set_key
    
  def validate_and_set_format
    render(:text => 'Invalid format', :status => :bad_request) and return unless params[:format] and FORMATS.include? params[:format]
  end
  private :validate_and_set_format
  
  def increment_uses
    @key.increment!(:uses) if @key
  end
  private :increment_uses  
  
  def render_error(e)
    render_jsend_error(e.message)
  end
    
  def render_jsend(data)
    render :json => { :status => 'success', :data => data } and return
  end
  protected :render_jsend
  
  def render_jsend_fail(errors)
    Rails.logger.debug("************render_jsend_fail called with #{errors}")
    render :json => { :status => 'fail', :data => errors }, :status => :bad_request and return
  end
  protected :render_jsend_fail
  
  def render_jsend_error(message)
    render :json => { :status => 'error', :message => message }, :status => :internal_server_error and return
  end
  protected :render_jsend_error
  
end
