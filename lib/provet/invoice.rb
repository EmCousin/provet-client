# frozen_string_literal: true

module Provet
  class Invoice < Provet::Base
    private

    def endpoint_name
      'invoice'
    end
  end
end
