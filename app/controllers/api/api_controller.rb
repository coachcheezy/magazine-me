class Api::ApiController < ApplicationController
  
  before_filter :validate_and_set_format, :increment_uses
  # skip_before_filter :redirect_for_third_party_domain
  
  FORMATS = ['json']
  
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


  # if a call could be made either with a user's uuid in the URL OR coming from a cookie, 
  # let this method figure it out and then just set @user
  def get_logged_in_user_or_user_by_uuid
    if not logged_in? and (params[:uuid].nil? or User.find_by_uuid(params[:uuid]).nil?)
      return render_jsend_fail :user_id => 'No user logged in or user_id not found'
    end

    if logged_in?
      @user = current_user
    else
      @user = User.find_by_uuid(params[:uuid])
    end
  end
  protected :get_logged_in_user_or_user_by_uuid
  
  
  def increment_uses
    @key.increment!(:uses) if @key
  end
  private :increment_uses
  
  
  # validate user info and return user object
  def get_user
    render_jsend_fail :user_id => 'user_id is required' and return if params[:uuid].nil? 
    render_jsend_fail :user_id => 'user_id not found' and return unless @user = User.find_by_uuid(params[:uuid])
  end
  protected :get_user
  
  
  # render error
  def render_error(e)
    render_jsend_error(e.message)
  end
  
  
  # See http://labs.omniti.com/labs/jsend for a description of JSend
  
  # `data` should be a hash of something, either a single record or an array of results:
  #
  #   { :user => { :id => 1, :first_name => 'Eugene' }}
  #
  #   { :users => [ { :id => 1, :first_name => 'Eugene' },
  #                 { :id => 2, :first_name => 'John' }]}
  
  def render_jsend(data)
    render :json => { :status => 'success', :data => data } and return
  end
  protected :render_jsend
  
  
  # `errors` should be an array of errors that prevented the request from completing:
  #
  #   [ { :title => 'Title is required', :body => 'Body is required' }]
  
  def render_jsend_fail(errors)
    Rails.logger.debug("************render_jsend_fail called with #{errors}")
    render :json => { :status => 'fail', :data => errors }, :status => :bad_request and return
  end
  protected :render_jsend_fail
  
  
  # `message` should be a string describing what went wrong:
  #
  #    'There was a problem communicating with the Facebook API. Please try again.'
  
  def render_jsend_error(message)
    render :json => { :status => 'error', :message => message }, :status => :internal_server_error and return
  end
  protected :render_jsend_error
  
end
