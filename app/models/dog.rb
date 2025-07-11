class Dog < Pet
  validates :tracker_type, inclusion: { in: %w[small medium big] }, allow_nil: false

  def lost_tracker
    raise NoMethodError, "Dogs don't have lost_tracker attribute"
  end

  def attributes
    super.except("lost_tracker")
  end
end
