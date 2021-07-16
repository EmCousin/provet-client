# frozen_string_literal: true

module Provet
  class Client < Provet::Base
    private

    def soft_deletable?
      true
    end

    def endpoint_name
      "client"
    end
  end
end
