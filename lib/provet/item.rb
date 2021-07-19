# frozen_string_literal: true

module Provet
  class Item < Provet::Base
    def initialize(type_code:)
      @type_code = type_code
    end

    private

    def endpoint_name
      @type_code
    end

    def soft_deletable?
      true
    end
  end
end
