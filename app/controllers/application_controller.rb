class ApplicationController < ActionController::API
  before_action :load_schema

  rescue_from ActionController::ParameterMissing do |error|
    render json: {
      errors: [{
                 status: "422",
                 title: "Invalid Parameters",
                 detail: error.message,
                 source: {
                   pointer: error.param
                 }
               }]
    }, status: :unprocessable_entity
  end

  private

  def load_schema
    # Dirty but gets the in-memory DB working
    if ActiveRecord::Base.connection.tables.exclude?("schema_migrations")
      load Rails.root.join("db/schema.rb")
    end
  end
end
