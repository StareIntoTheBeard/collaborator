class AttachmentsController < ApplicationController
  load_and_authorize_resource :through => :topic
  before_filter :appname

  def authorize
    if params[:oauth_token] then
      dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
      dropbox_session.authorize(params)
      session[:dropbox_session] = dropbox_session.serialize # re-serialize the authenticated session

      redirect_to :action => 'upload'
    else
      dropbox_session = Dropbox::Session.new('no9vn5wb40fgm05', 'obk9bj95z4shb8e')
      session[:dropbox_session] = dropbox_session.serialize
      redirect_to dropbox_session.authorize_url(:oauth_callback => url_for(:action => 'authorize'))
    end
  end

  def upload
    return redirect_to(:action => 'authorize') unless session[:dropbox_session]
    dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
    return redirect_to(:action => 'authorize') unless dropbox_session.authorized?

    if request.method == :post then
      dropbox_session.upload params[:file], 'My Uploads'
      render :text => 'Uploaded OK'
    else
      # display a multipart file field form
    end
  end

  def appname
    
  end

end
