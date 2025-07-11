class OutsideOfZoneSerializer
  include JSONAPI::Serializer

  set_type :outside_of_zone
  set_id { "outside_of_zone" }

  attribute :total

  attribute :groups do |object|
    object.groups.each_with_object({}) do |((type, tracker_type), count), result|
      result[type] ||= {}
      result[type][tracker_type] = count
    end
  end
end
