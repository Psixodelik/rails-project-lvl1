# frozen_string_literal: true

module HexletCode
  # Class for create HTML-tag markup
  class Tag
    def self.build(tag, *attrs)
      body = block_given? ? yield : nil
      attributes = attr_to_s(*attrs, '=')

      render(tag, body, attributes)
    end

    def self.paired?(tag)
      unpaired_tags = %w[
        br
        img
        input
      ]

      !unpaired_tags.include? tag
    end

    def self.boolean?(value)
      value.is_a?(TrueClass) || value.is_a?(FalseClass)
    end

    def self.attr_to_s(hash = nil, sep)
      return nil if hash.nil?

      hash.map do |key, value|
        value_normalize = boolean?(value) ? nil : "\"#{value}\""
        sep = value_normalize.nil? ? nil : sep

        "#{key}#{sep}#{value_normalize}" if value != false
      end.join ' '
    end

    def self.insert_start_space(string)
      string.insert(0, ' ')
    end

    def self.render(tag, body, attributes)
      attributes = insert_start_space(attributes) unless attributes.nil?
      close_tag = paired?(tag) ? "</#{tag}>" : nil

      body = body.join if body.is_a?(Array)

      "<#{tag}#{attributes}>#{body}#{close_tag}"
    end
  end
end
