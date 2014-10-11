class OnlySuperAdminsAuthorization < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    case subject
    when normalized(AdminUser)
      if user.super_admin?
        true
      else
        false
      end
    else
      true
    end
  end

end