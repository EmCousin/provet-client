# frozen_string_literal: true

require_relative 'base'

module Provet
  class Appointment < Provet::Base
    private

    def endpoint_name
      'appointment'
    end

    def soft_deletable?
      true
    end

    def archive_payload
      { active: 0 }.to_json
    end

    def restore_payload
      { active: 1 }.to_json
    end
  end
end
