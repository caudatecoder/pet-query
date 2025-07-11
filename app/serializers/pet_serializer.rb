class PetSerializer
  include JSONAPI::Serializer

  attributes :tracker_type, :owner_id, :in_zone

  attribute :pet_type do |pet|
    pet.type
  end

  attribute :lost_tracker, if: Proc.new { |pet| pet.type == "Cat" }
end
