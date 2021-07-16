# frozen_string_literal: true

require "httparty"

module Provet
  class Base
    include HTTParty

    base_uri "#{Provet.api_host}/#{Provet.instance}/api/#{Provet.api_version}"

    def list(query = {})
      get(collection_path, query: query)
    end

    def all(query = {})
      data = list(page: 1, **query)
      return [] if data["results"].blank? || data["num_pages"].blank?

      num_pages = data["num_pages"]
      return data["results"] if num_pages <= 1

      results = data["results"]
      (2..num_pages).each do |page_index|
        data = list(page: page_index, **query)
        results += data["results"]
      end
      results
    end

    def find(id_ext)
      get(resource_path(id_ext))
    end

    def create(body)
      post(collection_path, body)
    end

    def update(id_ext, body, verb: :put)
      send(verb, resource_path(id_ext), body)
    end

    def destroy(id_ext)
      delete(resource_path(id_ext))
    end

    def collection_url
      File.join(self.class.base_uri, collection_path)
    end

    def collection_path
      File.join("/", endpoint_name, "/")
    end

    def resource_url(id_ext)
      File.join(self.class.base_uri, resource_path(id_ext))
    end

    def resource_path(id_ext)
      File.join(collection_path, id_ext.to_s, "/")
    end

    protected

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
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "Authorization" => "Token #{Provet.token}"
      }
    end

    def endpoint_name
      raise "Must be overriden by subclass"
    end
  end
end
