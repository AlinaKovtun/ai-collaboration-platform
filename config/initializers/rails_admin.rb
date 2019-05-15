# frozen_string_literal: true

RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
    redirect_to main_app.root_path if current_user.nil? || !current_user.admin?
  end
  config.current_user_method(&:current_user)

  config.model 'User' do
    list do
      filters %i[first_name email approved]
      field :first_name do
        filterable true
      end
      field :email do
        filterable true
      end
      field :approved do
        filterable true
      end
    end
  end

  config.model 'News' do
    list do
      filters %i[title short_information approved]
      field :title do
        filterable true
      end
      field :short_information do
        filterable true
      end
      field :approved do
        filterable true
      end
    end
  end

  config.model 'Events' do
    list do
      filters %i[title description event_start event_end cost]
      field :title do
        filterable true
      end
      field :description do
        filterable true
      end
      field :event_start do
        filterable true
      end
      field :event_end do
        filterable true
      end
      field :cost do
        filterable true
      end
    end
  end

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
