# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MonstersExtendedController, type: :controller do

  def create_monsters
    FactoryBot.create_list(:monster, 1)
  end

  it 'should get all monsters correctly' do
    create_monsters
    get :index
    response_data = JSON.parse(response.body)['data']

    expect(response).to have_http_status(:ok)
    expect(response_data[0]['name']).to eq('My monster Test')
  end

  it 'should import all the CSV objects into the database successfully' do
    upload = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/storage/files/monsters-correct.csv')))
    post :import, params: { file: upload }
    expect(Monster.all.length).to eq(11)
  end

  it 'should sort the Monsters by speed' do
    monsters = [
      {name: 'bob', attack: 1, defence: 1, hp: 1, speed: 1, imageUrl: 'https://example.com/image.jpg'}, 
      {name: 'dave', attack: 2, defence: 2, hp: 2, speed: 2, imageUrl: 'https://example.com/image.jpg'}, 
      {name: 'tom', attack: 3, defence: 3, hp: 3, speed: 3, imageUrl: 'https://example.com/image.jpg'}, 
      {name: 'dick', attack: 4, defence: 4, hp: 4, speed: 4, imageUrl: 'https://example.com/image.jpg'}
    ]
    
    monsters.map do |m| 
      FactoryBot.create(:monster, name: m[:name], attack: m[:attack], defence: m[:defence], hp: m[:hp], speed: m[:speed], imageUrl: m[:imageUrl])
    end
    get :index
    response_data = JSON.parse(response.body)['data']

    expect(response_data[0]['name']).to eq('dick')
    expect(response_data[3]['name']).to eq('bob')
  end

  it 'should fail when importing csv file with nonexistent columns' do
    upload = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/storage/files/monsters-empty-monster.csv')))

    post :import, params: { file: upload }
    expect(response).to have_http_status(:bad_request)
  end

  it 'should fail when importing csv file with wrong columns' do
    upload = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/storage/files/monsters-wrong-column.csv')))

    post :import, params: { file: upload }
    expect(response).to have_http_status(:bad_request)
  end

  it 'should fail when importing file with different extension' do
    upload = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/storage/files/monsters-correct.xlsx')))

    post :import, params: { file: upload }
    expect(response).to have_http_status(:bad_request)
  end

  # I don't know whar 'none file' means
  # it 'should fail when importing none file' do
  #   upload = ''
  #   post :import, params: { file: upload }
  #   expect(response).to have_http_status(:bad_request)
  # end
end
