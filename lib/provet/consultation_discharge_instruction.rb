# frozen_string_literal: true

module Provet
  class ConsultationDischargeInstruction < Provet::Base
    def initialize(consultation_id:)
      @consultation_id = consultation_id
    end

    def destroy(*_args)
      raise MethodNotAllowedError
    end

    private

    def endpoint_name
      "consultation/#{@consultation_id}/consultationdischargeinstruction"
    end
  end
end
