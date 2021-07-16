# frozen_string_literal: true

require 'active_support/core_ext/module/attribute_accessors'

module Provet
  class Error < StandardError; end

  mattr_accessor :host
  @@host = 'https://us.provetcloud.com'

  mattr_accessor :instance
  @@instance = nil

  mattr_accessor :api_version
  @@api_version = '0.1'

  mattr_accessor :token
  @@token = nil
end

require_relative 'provet/version'
require_relative 'provet/base'
require_relative 'provet/appointment'
require_relative 'provet/availability'
require_relative 'provet/client'
require_relative 'provet/consultation_discharge_instruction'
require_relative 'provet/consultation_item_template'
require_relative 'provet/consultation_item'
require_relative 'provet/consultation'
require_relative 'provet/department'
require_relative 'provet/invoice_row'
require_relative 'provet/invoice'
require_relative 'provet/item_list'
require_relative 'provet/item_template_item'
require_relative 'provet/item'
require_relative 'provet/laboratory_analysis_group'
require_relative 'provet/patient'
require_relative 'provet/phone_number'
require_relative 'provet/reason_group'
require_relative 'provet/reason'
require_relative 'provet/reminder_template'
require_relative 'provet/reminder'
require_relative 'provet/user_details'
