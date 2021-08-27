# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  class Tag
    def self.build(tag, *attrs)
      body = block_given? ? yield : nil
      attributes = hash_to_s(*attrs, "=")

      render(tag, body, attributes)
    end

    private

    def self.paired?(tag)
      unpaired_tags = [
        'br',
        'img',
        'input'
      ]
      
      !unpaired_tags.include? tag 
    end

    def self.hash_to_s(hash = nil, sep)
      return nil if hash.nil?
      hash.map{ |key, value| "#{key}#{sep}'#{value}'"}
          .join " "
    end

    def self.insert_start_space(string)
      string.insert(0, " ")
    end

    def self.render(tag, body, attributes) 
      attributes = insert_start_space(attributes) if !attributes.nil?
      close_tag = paired?(tag) ? "</#{tag}>" : nil

      result = "<#{tag}#{attributes}>#{body}#{close_tag}"
    end
  end
end
