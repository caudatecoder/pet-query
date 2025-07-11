class Cat < Pet
  validates :tracker_type, inclusion: { in: %w[small big] }, allow_nil: false
  validates :lost_tracker, inclusion: { in: [true, false] }
end
