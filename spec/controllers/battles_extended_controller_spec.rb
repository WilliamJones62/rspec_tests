# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BattlesExtendedController, type: :controller do
  before(:each) do
    @monster1 = FactoryBot.create(:monster,
                                  name: 'My monster Test 1',
                                  attack: 40,
                                  defense: 20,
                                  hp: 50,
                                  speed: 80,
                                  imageUrl: 'https://example.com/image.jpg')

    @monster2 = FactoryBot.create(:monster,
                                  name: 'My monster Test 2',
                                  attack: 30,
                                  defense: 20,
                                  hp: 40,
                                  speed: 70,
                                  imageUrl: 'https://example.com/image.jpg')

    @monster3 = FactoryBot.create(:monster,
                                  name: 'My monster Test 3',
                                  attack: 30,
                                  defense: 20,
                                  hp: 40,
                                  speed: 80,
                                  imageUrl: 'https://example.com/image.jpg')

    # Please include additional monsters here for testing purposes.
  end

  def create_battles
    FactoryBot.create_list(:battle, 2)
  end

  # TODO: Update the below test as necessary
  it 'should create battle with bad request if one parameter is null' do
    parameters = {:monsterA_id => @monster1.id, :monsterB_id => nil}
    post :create, params: { battle: parameters }
    expect(response).not_to have_http_status(:ok)
  end

  # TODO: Update the below test as necessary
  it 'should create battle with bad request if monster does not exists' do
    parameters = {:monsterA_id => @monster1.id, :monsterB_id => 5}
    post :create, params: { battle: parameters }
    expect(response).not_to have_http_status(:ok)
  end

  # TODO: Update the below test as necessary
  it 'should create battle correctly with monsterA winning' do
    parameters = {:monsterA_id => @monster1.id, :monsterB_id => @monster2.id}
    post :create, params: { battle: parameters }
    response_data = JSON.parse(response.body)['data']
    expect(response_data['winner_id']).to eq(1)
  end

  # TODO: Update the below test as necessary
  it 'should create battle correctly with monsterB winning with equal defense and monsterB higher speed' do
    parameters = {:monsterA_id => @monster2.id, :monsterB_id => @monster3.id}
    post :create, params: { battle: parameters }
    response_data = JSON.parse(response.body)['data']
    expect(response_data['winner_id']).to eq(3)
  end

  # TODO: Update the below test as necessary
  it 'should delete a battle correctly' do
    create_battles
    delete :destroy, params: { id: Battle.last }

    expect(response).to have_http_status(:ok)
  end

  # TODO: Update the below test as necessary
  it 'should fail delete when battle does not exist' do
    delete :destroy, params: { id: 99 }

    expect(response).to have_http_status(:not_found)
  end
end
