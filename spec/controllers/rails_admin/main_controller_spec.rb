# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RailsAdmin::MainController, type: :controller do
  routes { RailsAdmin::Engine.routes }

  describe 'Check access to admin panel for User' do
    let(:user) { create(:user, :student) }

    before do
      sign_in user
    end

    it 'redirects to root path' do
      get :dashboard
      expect(response).to redirect_to(request.path)
    end
  end

  describe 'Check access to admin panel for Admin' do
    let(:user) { create(:user, :admin) }
    before do
      sign_in user
    end

    it 'render dashboard page' do
      get :dashboard
      expect(response).to render_template 'rails_admin/main/dashboard'
    end
  end
end
