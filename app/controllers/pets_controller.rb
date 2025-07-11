class PetsController < ApplicationController
  OutsideZoneStats = Data.define(:total, :groups)

  def index
    # looks scary, right? pagination would really be useful here
    pets = Pet.all
    render json: PetSerializer.new(pets).serializable_hash
  end

  def outside_of_zone
    total = Pet.where(in_zone: false).count

    grouped_counts = Pet.where(in_zone: false)
                        .group(:type, :tracker_type)
                        .count

    stats = OutsideZoneStats.new(
      total: total,
      groups: grouped_counts
    )

    render json: OutsideOfZoneSerializer.new(stats).serializable_hash
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      head :created
    else
      render json: {
        errors: pet.errors.map do |field, message|
          {
            status: "422",
            title: "Validation Error",
            detail: message,
            source: { pointer: "/data/attributes/#{field}" }
          }
        end
      }, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:data).require(:attributes).permit(:tracker_type, :owner_id, :in_zone, :lost_tracker, :type)
  end
end
