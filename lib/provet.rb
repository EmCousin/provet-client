# frozen_string_literal: true

require_relative 'provet/base'

module Provet
  class Error < StandardError; end

  @@host = 'https://us.provetcloud.com'
  @@instance = nil
  @@api_version = '0.1'
  @@token = nil

  def self.host
    @@host
  end

  def self.host=(value)
    @@host = value
    set_base_uri
  end

  def self.instance
    @@instance
  end

  def self.instance=(value)
    @@instance = value
    set_base_uri
  end

  def self.api_version
    @@api_version
  end

  def self.api_version=(value)
    @@api_version = value
    set_base_uri
  end

  def self.token
    @@token
  end

  def self.token=(value)
    @@token = value
  end

  def self.set_base_uri
    Provet::Base.base_uri("#{host}/#{instance}/api/#{api_version}")
  end
end


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
