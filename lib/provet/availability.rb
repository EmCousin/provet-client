# frozen_string_literal: true

module Provet
  class Availability < Provet::Base
    private

    def endpoint_name
      # should be 'availability', not 'availibility'
      # but that's how the endpoint is implemented
      'veterinarians_availibility'
    end
  end
end
