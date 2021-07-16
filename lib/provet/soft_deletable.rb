# frozen_string_literal: true

module Provet
  module SoftDeletable
    def destroy(id_ext)
      return super unless soft_deletable?

      soft_delete(id_ext)
    end

    def restore(id_ext)
      return unless soft_deletable?

      update(id_ext, restore_payload, verb: :patch)
    end

    protected

    def soft_delete(id_ext)
      update(id_ext, archive_payload, verb: :patch)
    end

    def soft_deletable?
      false
    end

    def archive_payload
      { archived: 1 }.to_json
    end

    def restore_payload
      { archived: 0 }.to_json
    end
  end
end
