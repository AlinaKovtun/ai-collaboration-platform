# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shared/_header.html.haml', type: :view do
  before(:each) do
    allow(view).to receive(:url_for).and_return('http://localhost:3000/uk/users/edit')
  end

  context 'when user is not signed in' do
    it 'shows "Sign up" link' do
      render
      expect(rendered).to include('Sign up')
    end

    it 'shows "Login" link' do
      render
      expect(rendered).to include('Login')
    end

    it 'doesn`t include "Edit profile" link' do
      render
      expect(rendered).not_to include('Edit profile')
    end

    it 'doesn`t include "Logout" link' do
      render
      expect(rendered).not_to include('Logout')
    end
  end

  context 'when user is signed in' do
    let(:user) { create :user }

    before(:each) do
      sign_in user
    end

    it 'shows "Edit profile" link' do
      render
      expect(rendered).to include('Edit profile')
    end

    it 'shows "Logout" link' do
      render
      expect(rendered).to include('Logout')
    end

    it 'doesn`t include "Sign up" link' do
      render
      expect(rendered).not_to include('Sign up')
    end

    it 'doesn`t include "Login" link' do
      render
      expect(rendered).not_to include('Login')
    end
  end
end
