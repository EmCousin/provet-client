# frozen_string_literal: true

require_relative 'base'

module Provet
  class Availability < Provet::Base
    private

    def endpoint_name
      'veterinarians_availibility'
    end
  end
end
