class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        resource.ensure_authentication_token!
        render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
        return
      else
        expire_session_data_after_sign_in!
        render :json=> {:success=>false, :message=>"User is inactive"}, :status=>401
      end
    else
      clean_up_passwords resource
      render :json=> {:success=>false, :message=>"Unable to save user"}, :status=>401
    end
  end
end