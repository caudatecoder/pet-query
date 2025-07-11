class ApplicationController < ActionController::API
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
end
