# frozen_string_literal: true

module Provet
  class Invoice < Provet::Base
    def create(_body)
      raise MethodNotAllowedError
    end

    def destroy(_id)
      raise MethodNotAllowedError
    end

    private

    def endpoint_name
      'invoice'
    end
  end
end
