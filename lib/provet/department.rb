# frozen_string_literal: true

module Provet
  class Department < Provet::Base
    def create(_body)
      raise MethodNotAllowedError
    end

    def update(*_args)
      raise MethodNotAllowedError
    end

    def destroy(_id)
      raise MethodNotAllowedError
    end

    private

    def endpoint_name
      'department'
    end
  end
end
