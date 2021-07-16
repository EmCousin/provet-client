# frozen_string_literal: true

require 'provet/base'
require 'provet/appointment'
require 'provet/availability'
require 'provet/client'
require 'provet/consultation_discharge_instruction'
require 'provet/consultation_item_template'
require 'provet/consultation_item'
require 'provet/consultation'
require 'provet/department'
require 'provet/invoice_row'
require 'provet/invoice'
require 'provet/item_list'
require 'provet/item_template_item'
require 'provet/item'
require 'provet/laboratory_analysis_group'
require 'provet/patient'
require 'provet/phone_number'
require 'provet/reason_group'
require 'provet/reason'
require 'provet/reminder_template'
require 'provet/reminder'
require 'provet/user_details'

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
