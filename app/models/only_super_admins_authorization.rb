class OnlySuperAdminsAuthorization < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    case subject
    when normalized(AdminUser)
      if action == :update || action == :destroy
        user.super_admin == true
      else
        false
      end
    else
      true
    end
  end

end