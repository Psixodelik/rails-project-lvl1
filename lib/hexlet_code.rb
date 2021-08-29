# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/form_elements'
require_relative 'hexlet_code/tag'

module HexletCode
  class Error < StandardError; end

  def self.form_for(option, action = "#")
    action = action[:url] if action.is_a?(Hash) && action.key?(:url)

    form = self::FormElements.new option
    form_elements = yield form

    self::Tag.build 'form', action: action, method: 'post' do
      form_elements
    end
  end
end

