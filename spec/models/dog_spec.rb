require 'rails_helper'

RSpec.describe Dog do
  describe 'validations' do
    context 'tracker_type' do
      context 'with a valid tracker type' do
        it 'is valid' do
          dog = build(:dog, :valid, tracker_type: 'small')
          expect(dog).to be_valid
        end
      end

      context 'with incorrect tracker type' do
        it 'is invalid' do
          dog = build(:dog, :valid, tracker_type: 'enormous')
          expect(dog).not_to be_valid
        end
      end


      context 'without a tracker type' do
        it 'is invalid' do
          dog = build(:dog, tracker_type: nil)
          expect(dog).not_to be_valid
        end
      end
    end
  end

  describe '#lost_tracker' do
    it 'raises NoMethodError when accessing lost_tracker' do
      dog = build(:dog)
      expect { dog.lost_tracker }.to raise_error(NoMethodError)
    end
  end

  describe '#attributes' do
    it 'excludes lost_tracker from attributes' do
      dog = create(:dog, :valid)
      expect(dog.attributes.keys).not_to include('lost_tracker')
    end
  end
end
