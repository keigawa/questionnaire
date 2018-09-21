module ControllerMacros
  def login_admin(admin)
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    admin = User.create(email: 'admin@admin.com', password: '222222')
    sign_in admin
  end

  def login_user(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    Company.create(name: 'company')
    admin = User.create(email: 'admin@admin.com', name: 'username', password: '111111', president: false, company_id: 1)
    sign_in user
  end
end
