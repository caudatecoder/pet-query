require 'rails_helper'

RSpec.describe OutsideOfZoneSerializer do
  describe '#serializable_hash' do
    let(:count_value) { 42 }
    let(:groups) do
      {
        %w[Dog small] => 15,
        %w[Dog big] => 8,
        %w[Cat small] => 12,
        %w[Cat big] => 7
      }
    end
    let(:data) { PetsController::OutsideZoneStats.new(count_value, groups) }
    subject { described_class.new(data) }

    it 'includes the total value attribute' do
      expect(subject.serializable_hash.dig(:data, :attributes, :total)).to eq(count_value)
    end

    it 'has the expected structure' do
      expect(subject.serializable_hash).to match(
        data: {
          id: 'outside_of_zone',
          type: :outside_of_zone,
          attributes: {
            total: count_value,
            groups: {
              'Dog' => {
                'small' => 15,
                'big' => 8
              },
              'Cat' => {
                'small' => 12,
                'big' => 7
              }
            }
          }
        }
      )
    end
  end
end
