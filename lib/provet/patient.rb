# frozen_string_literal: true

module Provet
  class Patient < Provet::Base
    private

    def soft_deletable?
      true
    end

    def endpoint_name
      "patient"
    end
  end
end
