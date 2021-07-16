# frozen_string_literal: true

require_relative "provet/version"

module Provet
  class Error < StandardError; end

  mattr_accessor :host
  @@host = "https://us.provetcloud.com"

  mattr_accessor :instance
  @@instance = nil

  mattr_accessor :api_version
  @@api_version = "0.1"

  mattr_accessor :token
  @@token = nil
end
