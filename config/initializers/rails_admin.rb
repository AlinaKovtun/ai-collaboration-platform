# frozen_string_literal: true

# RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

 #  config.current_user_method(&:current_user)
 #
 # config.authenticate_with do
 #   authenticate_or_request_with_http_basic('Login required') do |email, password|
 #     role = Role.find_by_name('admin')
 #     user = User.where(email: email, role: role).first
 #     user.valid_password?(password) if user
 #   end
 # end

 RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.isAdmin?
  end

   config.model 'User' do
    list do
      filters [:first_name, :email]
      field :first_name do
        filterable true
      end
      field :email do
        filterable true
      end
     end
   end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
