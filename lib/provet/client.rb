# frozen_string_literal: true

require_relative 'base'

module Provet
  class Client < Provet::Base
    private

    def soft_deletable?
      true
    end

    def endpoint_name
      'client'
    end
  end
end
