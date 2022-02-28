# frozen_string_literal: true

require_relative './application'
require 'thin'

run API::Root
