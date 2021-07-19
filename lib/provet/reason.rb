# frozen_string_literal: true

module Provet
  class Reason < Provet::Base
    private

    def endpoint_name
      'reason'
    end

    def soft_deletable?
      true
    end
  end
end
