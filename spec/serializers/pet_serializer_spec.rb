require 'rails_helper'

RSpec.describe PetSerializer do
  describe '#serializable_hash' do
    context 'when serializing a cat' do
      let(:cat) { create(:cat, :valid) }
      subject { described_class.new(cat).serializable_hash }

      it 'serializes with correct attributes' do
        expect(subject.dig(:data, :attributes)).to match(
          tracker_type: cat.tracker_type,
          owner_id: cat.owner_id,
          in_zone: cat.in_zone,
          lost_tracker: cat.lost_tracker,
          pet_type: 'Cat'
        )
      end
    end

    context 'when serializing a dog' do
      let(:dog) { create(:dog, :valid) }
      subject { described_class.new(dog).serializable_hash }

      it 'serializes with correct attributes' do
        # no lost trackers here
        expect(subject.dig(:data, :attributes)).to match(
          tracker_type: dog.tracker_type,
          owner_id: dog.owner_id,
          in_zone: dog.in_zone,
          pet_type: 'Dog'
        )
      end
    end
  end
end
