# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BattlesController, type: :controller do
  def create_battles
    FactoryBot.create_list(:battle, 2)
  end

  it 'should get all battles correctly' do
    create_battles
    get :index
    response_data = JSON.parse(response.body)['data']

    expect(response).to have_http_status(:ok)
    expect(response_data.count).to eq(2)
  end
end
