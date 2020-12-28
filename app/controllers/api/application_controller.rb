class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token
rescue_from ActiveRecord:: RecordInvalid, with: :record_invalid

private
def record_invalid(error)

# For a ActiveRecord::InvalidRecord error, the .record
# method returns the 'model instance' that failed the validation
#  and raised the error
  invalid_record = error.record
     # {
        #   errors: [
        #     {
        #       type: "ActiveRecord::InvalidRecord",
        #       record_type: "Question",
        #       field: "body",
        #       message: "..."
        #     }
        #   ]
        # }



  errors = invalid_record.errors.map do |field, message|
    {
      type: error.class.to_s,
      record_type: invalid_record.class.to_s,
      field:field,
      message: message

    }
  end
  render(
    json: {status: 422, errors:errors},
    status: 422
  )

end

end
