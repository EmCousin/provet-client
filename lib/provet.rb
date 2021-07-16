# frozen_string_literal: true

require_relative 'provet/version'

require 'provet/base'

require 'provet/appointment'
require 'provet/availability'
require 'provet/client'
require 'provet/consultation_discharge_instructions'
require 'provet/consultation_item_template'
require 'provet/consultation_item'
require 'provet/consultation'
require 'provet/department'
require 'provet/invoice_row'
require 'provet/invoice'
require 'provet/item_list'
require 'provet/item_template_item'
require 'provet/item'
require 'provet/laborator_analysis_group'
require 'provet/patient'
require 'provet/phone_number'
require 'provet/reason_group'
require 'provet/reason'
require 'provet/reminder_template'
require 'provet/reminder'
require 'provet/user_details'

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
