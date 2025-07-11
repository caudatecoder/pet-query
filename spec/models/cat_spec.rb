require 'rails_helper'

RSpec.describe Cat do
  describe 'validations' do
    context 'tracker_type' do
      context 'with a valid tracker type' do
        it 'is valid' do
          cat = build(:cat, :valid, tracker_type: 'small')
          expect(cat).to be_valid
        end
      end

      context 'with :medium tracker type' do
        it 'is invalid' do
          # medium is not a valid tracker type for Cats
          cat = build(:cat, :valid, tracker_type: 'medium')
          expect(cat).not_to be_valid
        end
      end

      context 'without a tracker type' do
        it 'is invalid' do
          cat = build(:cat, :valid, tracker_type: nil)
          expect(cat).not_to be_valid
        end
      end
    end

    context 'lost_tracker' do
      context 'with valid boolean values' do
        it 'is valid with true' do
          cat = build(:cat, :valid, lost_tracker: true)
          expect(cat).to be_valid
        end

        it 'is valid with false' do
          cat = build(:cat, :valid, lost_tracker: false)
          expect(cat).to be_valid
        end
      end

      context 'with nil value' do
        it 'is invalid' do
          cat = build(:cat, :valid, lost_tracker: nil)
          expect(cat).not_to be_valid
        end
      end
    end
  end

  describe '#attributes' do
    it 'includes lost_tracker in attributes' do
      cat = create(:cat, :valid)
      expect(cat.attributes.keys).to include('lost_tracker')
    end
  end
end
