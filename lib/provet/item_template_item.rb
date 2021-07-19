# frozen_string_literal: true

module Provet
  class ItemTemplateItem < Provet::Base
    private

    def endpoint_name
      'itemtemplateitem'
    end

    def soft_deletable?
      true
    end
  end
end
