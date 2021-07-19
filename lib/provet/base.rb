# frozen_string_literal: true

require 'httparty'

module Provet
  class Base
    include HTTParty

    def list(query = {})
      get(collection_path, query: query)
    end

    def all(query = {})
      data = list(page: 1, **query)

      return [] unless data['results'].is_a?(Array) && data['results'].any? && data['num_pages'].is_a?(Integer)

      num_pages = data['num_pages']
      return data['results'] if num_pages <= 1

      results = data['results']
      (2..num_pages).each do |page_index|
        data = list(page: page_index, **query)
        results += data['results']
      end
      results
    end

    def find(id)
      get(resource_path(id))
    end

    def create(body)
      post(collection_path, body)
    end

    def update(id, body, verb: :put)
      send(verb, resource_path(id), body)
    end

    def destroy(id, hard: !soft_deletable?)
      if hard
        delete(resource_path(id))
      else
        patch(resource_path(id), archive_payload)
      end
    end

    def really_destroy!(id)
      raise MethodNotAllowedError unless soft_deletable?

      destroy(id, hard: true)
    end

    def restore(id)
      raise MethodNotAllowedError unless soft_deletable?

      patch(resource_path(id), restore_payload)
    end

    def collection_url
      File.join(self.class.base_uri, collection_path)
    end

    def collection_path
      File.join('/', endpoint_name, '/')
    end

    def resource_url(id)
      File.join(self.class.base_uri, resource_path(id))
    end

    def resource_path(id)
      File.join(collection_path, id.to_s, '/')
    end

    protected

    def soft_deletable?
      false
    end

    def archive_payload
      { archived: 1 }.to_json
    end

    def restore_payload
      { archived: 0 }.to_json
    end

    def get(path, query: {})
      options = default_options
      options[:query] ||= default_query
      options[:query].merge!(query) if query.any?

      self.class.get(path, options)
    end

    def post(path, body)
      self.class.post(path, default_options.merge(body: body))
    end

    def put(path, body)
      self.class.put(path, default_options.merge(body: body))
    end

    def patch(path, body)
      self.class.patch(path, default_options.merge(body: body))
    end

    def delete(path)
      self.class.delete(path, default_options)
    end

    def default_options
      { headers: headers }
    end

    def default_query
      {}
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Token #{Provet.token}"
      }
    end

    def endpoint_name
      raise 'Must be overriden by subclass'
    end
  end
end
