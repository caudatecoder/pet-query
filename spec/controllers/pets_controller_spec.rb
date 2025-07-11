# spec/requests/pets_controller_spec.rb
require 'rails_helper'

RSpec.describe PetsController, type: :request do
  describe 'GET /pets' do
    it 'returns all pets in the database' do
      create_list(:dog, 2, :valid)
      create_list(:cat, 3, :valid)

      get '/pets'

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['data'].length).to eq(5)
    end

    it 'returns correct structure for a dog record' do
      dog = create(:dog, :valid)

      get '/pets'

      json_response = JSON.parse(response.body)
      dog_data = json_response['data'].first
      expect(dog_data['attributes']).to include(
                                          'pet_type' => 'Dog',
                                          'tracker_type' => dog.tracker_type,
                                          'owner_id' => dog.owner_id,
                                          'in_zone' => dog.in_zone
                                        )
      expect(dog_data['attributes']).not_to include('lost_tracker')
    end

    it 'returns correct structure for a cat record' do
      cat = create(:cat, :valid)

      get '/pets'

      json_response = JSON.parse(response.body)
      cat_data = json_response['data'].first
      expect(cat_data['attributes']).to include(
                                          'pet_type' => 'Cat',
                                          'tracker_type' => cat.tracker_type,
                                          'owner_id' => cat.owner_id,
                                          'in_zone' => cat.in_zone,
                                          'lost_tracker' => cat.lost_tracker
                                        )
    end
  end

  describe 'GET /pets/outside_of_zone' do
    context "with pets outside the zone" do
      before do
        create_list(:dog, 2, :valid, in_zone: false, tracker_type: 'medium')
        create_list(:dog, 2, :valid, in_zone: false, tracker_type: 'big')
        create_list(:dog, 1, :valid, in_zone: true)
        create_list(:cat, 3, :valid, in_zone: false, tracker_type: 'small')
        create_list(:cat, 2, :valid, in_zone: true)
      end

      it 'returns correct count of pets outside the zone' do
        get '/pets/outside_of_zone'

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['total']).to eq(7)
      end

      it 'returns data grouped by pet type and tracker type' do
        get '/pets/outside_of_zone'

        json_response = JSON.parse(response.body)
        expect(json_response['data']['attributes']['groups']['Dog']['big']).to eq(2)
      end
    end

    it 'returns zero when all pets are in zone' do
      create_list(:dog, 2, :valid, in_zone: true)
      create_list(:cat, 2, :valid, in_zone: true)

      get '/pets/outside_of_zone'

      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['total']).to eq(0)
    end

    it 'returns zero when no pets exist' do
      get '/pets/outside_of_zone'

      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['total']).to eq(0)
    end
  end

  describe 'POST /pets' do
    it 'creates a dog record successfully' do
      dog_params = {
        data: {
          attributes: {
            type: 'Dog',
            tracker_type: 'medium',
            owner_id: 123,
            in_zone: true
          }
        }
      }

      post '/pets', params: dog_params.to_json, headers: { 'Content-Type': 'application/json' }

      expect(response).to have_http_status(:created)
      expect(Dog.count).to eq(1)
    end

    it 'creates a cat record successfully' do
      cat_params = {
        data: {
          attributes: {
            type: 'Cat',
            tracker_type: 'small',
            owner_id: 123,
            in_zone: true,
            lost_tracker: false
          }
        }
      }

      post '/pets', params: cat_params.to_json, headers: { 'Content-Type': 'application/json' }

      expect(response).to have_http_status(:created)
      expect(Cat.count).to eq(1)
    end


    context "with invalid pet data" do
      it 'returns validation errors' do
        invalid_params = {
          data: {
            attributes: {
              type: 'Cat',
              tracker_type: 'medium',
              owner_id: 123,
              in_zone: true
            }
          }
        }

        post '/pets', params: invalid_params.to_json, headers: { 'Content-Type': 'application/json' }

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
      end
    end

    context "with incorrectly formatted data" do
      it "returns unprocessable entity status" do
        invalid_params = {
          type: 'Cat',
          tracker_type: 'medium',
          owner_id: 123,
          in_zone: true
        }

        post '/pets', params: invalid_params.to_json, headers: { 'Content-Type': 'application/json' }

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
      end
    end
  end
end
