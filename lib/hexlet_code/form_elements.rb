# frozen_string_literal: true

module HexletCode
  # Rendering Form Element such as input, select
  class FormElements
    attr_reader :form_option
    attr_accessor :rendered_elements

    def initialize(data)
      @form_option = data
      @rendered_elements = []
    end

    def input(name, **option)
      default_element_type = :input
      value = form_option[name]

      attributes = option.merge({ name: name, value: value })
      element_type = option.is_a?(Hash) && option.key?(:as) ? attributes.delete(:as) : default_element_type

      rendered_elements.push case element_type
                             when :input
                               attributes[:type] = 'text'
                               input_render(**attributes)
                             when :text
                               textarea_render(name, value)
                             when :select
                               selected_value = value
                               options = option[:collection]

                               select_render(name, selected_value, options)
                             end
    end

    def submit(value = 'Save')
      attributes = { value: value, type: 'submit' }
      rendered_elements.push input_render(**attributes)
    end

    def input_render(**option)
      result = []

      if option[:type] == 'text'
        result.push HexletCode::Tag.build('label', for: option[:name]) { option[:name] }
      end

      result.push HexletCode::Tag.build('input', **option)
    end

    def textarea_render(name, value, cols = 20, rows = 40)
      HexletCode::Tag.build('textarea', name: name, cols: cols, rows: rows) { value }
    end

    def select_render(name, selected, collection)
      options = collection.map do |value|
        selected = value == selected
        HexletCode::Tag.build('option', value: value, selected: selected) { value }
      end

      HexletCode::Tag.build('select', name: name) { options }
    end
  end
end
