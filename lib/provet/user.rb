# frozen_string_literal: true

module Provet
  class User < Provet::Base
    private

    def soft_deletable?
      true
    end

    def endpoint_name
      "user"
    end

    def archive_payload
      { is_active: 0 }.to_json
    end

    def restore_payload
      { is_active: 1 }.to_json
    end
  end
end
