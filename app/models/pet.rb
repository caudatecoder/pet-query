class Pet < ApplicationRecord
  validates :type, inclusion: { in: %w[Cat Dog] }, allow_nil: false
  validates :tracker_type, presence: true
  validates :owner_id, presence: true
  validates :in_zone, inclusion: { in: [true, false] }

  abstract_class
end
